class CommentSerializer < ActiveModel::Serializer
  attributes :id, :description
  has_one :user
end
