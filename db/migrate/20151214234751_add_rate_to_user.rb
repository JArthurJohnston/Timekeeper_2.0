class AddRateToUser < ActiveRecord::Migration
  def change
    add_column :users, :rate, :decimal
  end
end
