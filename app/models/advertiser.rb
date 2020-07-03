class Advertiser < ApplicationRecord
  has_many :offers

  validates :name, presence: true
  validates :url, presence: true
end
