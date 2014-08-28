class Category < ActiveRecord::Base
	validates_presence_of :name
	validates_presence_of :description

	extend FriendlyId
  	friendly_id :name, use: :slugged

	has_many :articles, dependent: :nullify
end
