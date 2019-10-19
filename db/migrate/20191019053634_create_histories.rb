class CreateHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :histories do |t|
      t.string :country_name
      t.string :location
      t.string :source
      t.text :data_result

      t.timestamps
    end
  end
end
