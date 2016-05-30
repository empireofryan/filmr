class ScriptSerializer < ActiveModel::Serializer
  attributes :id, :title, :logline
  has_one :genre
end
