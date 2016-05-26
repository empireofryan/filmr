class Comment < ActiveRecord::Base
  belongs_to :script
  belongs_to :user
#  after_create :assign_user
end
