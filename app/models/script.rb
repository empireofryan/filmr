class Script < ActiveRecord::Base

  belongs_to :user
  belongs_to :genre
  has_many :comments

  validates :title, :logline, presence: :true

  def genre_attributes=(attributes)
    Genre.find_or_create_by(name: name)
  end

  def self.alpha_sorted
    Script.all.sort_by {|script| script.title}
  end

end