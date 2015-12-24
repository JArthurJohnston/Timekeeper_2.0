class AddPrescisionToRates < ActiveRecord::Migration
  def change
    change_column :users, :rate, :decimal, precision: 8, scale: 2
    change_column :statements_of_work, :rate, :decimal, precision: 8, scale: 2
  end
end
