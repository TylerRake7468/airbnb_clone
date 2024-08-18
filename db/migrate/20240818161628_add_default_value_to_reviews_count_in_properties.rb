class AddDefaultValueToReviewsCountInProperties < ActiveRecord::Migration[7.1]
  def change
    change_column :properties, :reviews_count, :integer, :default => 0
    #Ex:- :default =>''
    #Ex:- change_column("admin_users", "email", :string, :limit =>25)
  end
end
