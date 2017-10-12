class User < ApplicationRecord
  has_many :weather_requests

  validates :uniq_identifier, presence: true

end
