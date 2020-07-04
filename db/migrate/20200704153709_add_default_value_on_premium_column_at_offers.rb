class AddDefaultValueOnPremiumColumnAtOffers < ActiveRecord::Migration[6.0]
  def change
    change_column :offers, :premium, :boolean, :default => false
  end
end
