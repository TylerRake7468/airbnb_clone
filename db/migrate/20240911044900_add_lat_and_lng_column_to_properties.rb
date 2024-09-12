class AddLatAndLngColumnToProperties < ActiveRecord::Migration[7.1]
  def change
    add_column :properties, :lat, :decimal, default: 0
    add_column :properties, :lng, :decimal, default: 0
  end
end
