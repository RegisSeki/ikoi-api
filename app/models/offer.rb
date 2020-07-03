class Offer < ApplicationRecord
  belongs_to :advertiser

  validates :url, presence: true
  validates :description, presence: true
  validates :starts_at, presence: true
end
