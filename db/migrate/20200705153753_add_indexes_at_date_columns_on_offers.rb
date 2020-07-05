class AddIndexesAtDateColumnsOnOffers < ActiveRecord::Migration[6.0]
  def change
    add_index :offers, :starts_at
    add_index :offers, :ends_at
  end
end
