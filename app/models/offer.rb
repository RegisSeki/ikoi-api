class Offer < ApplicationRecord
  belongs_to :advertiser

  validates :url, presence: true
  validates_format_of :url, :with => /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i
  validates :description, presence: true, length: { maximum: 500 }
  validates :starts_at, presence: true

  def self.by_advertiser_id(advertiser_id)
    where(advertiser_id: advertiser_id)
  end

  def self.enabled_offers
    where("starts_at <= ? AND (ends_at >= ? OR ends_at IS NULL)", Time.now, Time.now).order("premium = true DESC")
  end
end
