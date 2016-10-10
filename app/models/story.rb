class Story < ApplicationRecord
  validates :name, :link, presence: true
  belongs_to :user
  has_many :votes do
    def latest
      order('id DESC').limit(3)
    end
  end

  def to_param
    "#{id}-#{name.gsub(/\W/, '-').downcase}"
  end
end
