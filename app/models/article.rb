class Article < ActiveRecord::Base
	acts_as_taggable_on :tags

	#relationship with other model
	belongs_to :category
	belongs_to :user
	has_many :comments

	extend FriendlyId
  	friendly_id :title, use: :slugged

	validates_presence_of :title, :body, :category_id
	validate :body, length: { minimum: 10 }
	#validates :description, length: { maximum: 200}
	
	scope :published, lambda { |publish| where("published = ?", publish)}
	scope :recent, lambda { |num| where(published: 1).order('created_at DESC').limit(num) }
end
