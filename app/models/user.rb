class User < ApplicationRecord
  has_secure_password
  has_many :stories
  has_many :votes
  has_many :stories_voted_on,
    through: :votes,
    source: :story

  def to_param
    "#{id}-#{name}"
  end
end
