class CreateAdvertisers < ActiveRecord::Migration[6.0]
  def change
    create_table :advertisers do |t|
      t.string :name, null: false
      t.string :url, null: false

      t.timestamps
    end
  end
end
