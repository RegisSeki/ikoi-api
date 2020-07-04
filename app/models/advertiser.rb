class Advertiser < ApplicationRecord
  has_many :offers

  validates :name, presence: true
  validates_uniqueness_of :name
  validates :url, presence: true
  validates_format_of :url, :with => /\A(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w\.-]*)*\/?\Z/i

  def self.by_id(id)
    where(:id)
  end
end
