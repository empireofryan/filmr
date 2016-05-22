class Genre < ActiveRecord::Base
  has_many :scripts
  has_many :users, :through => :scripts

  validates :name, presence: :true
end
