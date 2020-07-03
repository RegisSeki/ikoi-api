class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.references :advertiser, null: false, foreign_key: true
      t.string :url, null: false
      t.string :description, null: false, limit: 500
      t.datetime :starts_at, null: false
      t.datetime :ends_at
      t.boolean :premiun

      t.timestamps
    end
  end
end
