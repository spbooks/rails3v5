class Vote < ApplicationRecord
  belongs_to :story, counter_cache: true
  belongs_to :user
end
