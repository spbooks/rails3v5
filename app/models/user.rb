class User < ApplicationRecord
  has_secure_password
  has_many :stories
  has_many :votes
end
