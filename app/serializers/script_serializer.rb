class ScriptSerializer < ActiveModel::Serializer
  attributes :id, :title, :logline, :next_id, :prev_id
  has_one :genre
  has_many :comments

  def next_id
    #object.class.where("id > ?", object.id).first
    object.class.where('id > ?', object.id).order('id asc').limit(1).pluck(:id).first
  end

  def prev_id
    #object.class.where("id < ?", object.id).last
    object.class.where('id < ?', object.id).order('id desc').limit(1).pluck(:id).first
  end

end
