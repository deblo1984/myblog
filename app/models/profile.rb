class Profile < ActiveRecord::Base
	mount_uploader :avatar, ImageUploader
	validates_size_of :avatar, maximum: 1.megabytes
	validates_integrity_of :avatar
	validates_processing_of :avatar

	belongs_to :user
end
