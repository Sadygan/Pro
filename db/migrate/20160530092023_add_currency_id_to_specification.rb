class AddCurrencyIdToSpecification < ActiveRecord::Migration
  def change
    add_column :specifications, :currency_id, :integer
  end
end
