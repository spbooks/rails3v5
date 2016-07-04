class Story < ApplicationRecord
  validates :name, :link, presence: true
end
