class AddIndexAtPremiumTrueOnOffers < ActiveRecord::Migration[6.0]
  def change
    add_index(:offers, :premium, where: "true")
  end
end
