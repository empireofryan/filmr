class ScriptSerializer < ActiveModel::Serializer
  attributes :id, :title, :logline
  has_one :genre
  has_many :comments
end
