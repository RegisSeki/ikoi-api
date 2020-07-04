class Advertiser < ApplicationRecord
  has_many :offers

  validates :name, presence: true
  validates :url, presence: true

  def self.by_id(id)
    where(:id)
  end
end
