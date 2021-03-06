class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  has_secure_password

  has_many :movies, -> { order("created_at DESC") }
  has_many :reviews, dependent: :destroy
end