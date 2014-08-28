class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, #:registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #validate presence
  #validates :email, presence: true
  #validates :email, uniqueness: true
  #validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  #validates :password, presence: true
  #validates :password, confirmation: true
  #validates :password, length: { minimum: 5 }

  #validates length

  has_one :profile
  has_many :articles
  has_many :comments, :through => :articles

  before_save do | user |
    user.profile = Profile.new unless user.profile
  end
end
