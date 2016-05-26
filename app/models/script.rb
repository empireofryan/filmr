class Script < ActiveRecord::Base

  belongs_to :user
  belongs_to :genre
  has_many :comments

  after_save :assign_other_attributes

  validates :title, :logline, presence: :true

  def comments_attributes=(attributes)
    attributes.each do |k,v|
    comments << Comment.find_or_create_by(description: v['description'])

  end
  end

  def genre_attributes=(attributes)
   # Genre.find_or_create_by(name: name)
  end

  def self.alpha_sorted
    Script.all.sort_by {|script| script.title}
  end

  private

  def assign_other_attributes
    self.comments do |comment|
      comment.script = self
      if comment.user_id == nil
        comment.user_id = self.user_id
      end
    end
  end

end
