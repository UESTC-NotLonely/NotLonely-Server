class Group < ActiveRecord::Base
	belongs_to :user
	has_many :activities
	has_many :group_applies
end