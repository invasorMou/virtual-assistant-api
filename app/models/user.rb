class User < ApplicationRecord
  has_secure_password
  
  has_many :reminders, foreign_key: :created_by
  validates_presence_of :username, :email, :password_digest
  validates_uniqueness_of :email
end
