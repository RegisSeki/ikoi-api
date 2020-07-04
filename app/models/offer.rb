class Offer < ApplicationRecord
  belongs_to :advertiser

  validates :url, presence: true
  validates :description, presence: true
  validates :starts_at, presence: true

  def self.by_advertiser_id(advertiser_id)
    where(advertiser_id: advertiser_id)
  end
end
