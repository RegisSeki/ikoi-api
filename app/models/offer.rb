class Offer < ApplicationRecord
  belongs_to :advertiser

  validates :url, presence: true
  validates_format_of :url, :with =>  /\A(?:(?:https?|http):\/\/)(?:\S+(?::\S*)?@)?(?:(?!10(?:\.\d{1,3}){3})(?!127(?:\.\d{1,3}){3})(?!169\.254(?:\.\d{1,3}){2})(?!192\.168(?:\.\d{1,3}){2})(?!172\.(?:1[6-9]|2\d|3[0-1])(?:\.\d{1,3}){2})(?:[1-9]\d?|1\d\d|2[01]\d|22[0-3])(?:\.(?:1?\d{1,2}|2[0-4]\d|25[0-5])){2}(?:\.(?:[1-9]\d?|1\d\d|2[0-4]\d|25[0-4]))|(?:(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)(?:\.(?:[a-z\u00a1-\uffff0-9]+-?)*[a-z\u00a1-\uffff0-9]+)*(?:\.(?:[a-z\u00a1-\uffff]{2,})))(?::\d{2,5})?(?:\/[^\s]*)?\z/i
  validates :description, presence: true, length: { maximum: 500 }
  validates :starts_at, presence: true

  def self.by_advertiser_id(advertiser_id)
    where(advertiser_id: advertiser_id)
  end

  def self.enabled_offers
    where("starts_at <= ? AND (ends_at >= ? OR ends_at IS NULL)", Time.now, Time.now).order(Arel.sql("premium = true DESC"))
  end

  def self.order_by_desc
    order(id: :desc)
  end
end
