class AddRateToStatementOfWork < ActiveRecord::Migration
  def change
    add_column :statements_of_work, :rate, :decimal
  end
end
