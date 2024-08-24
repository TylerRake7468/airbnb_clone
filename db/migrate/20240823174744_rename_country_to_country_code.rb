class RenameCountryToCountryCode < ActiveRecord::Migration[7.1]
  def change
    rename_column :profiles, :country, :country_code
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
