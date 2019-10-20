class AddHarzardToHistories < ActiveRecord::Migration[6.0]
  def up
    add_column :histories, :hazard, :string
  end

  def down
    remove_column :histories, :hazard
  end
end
