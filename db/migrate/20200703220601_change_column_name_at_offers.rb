class ChangeColumnNameAtOffers < ActiveRecord::Migration[6.0]
  def change
    rename_column :offers, :premiun, :premium
  end
end
