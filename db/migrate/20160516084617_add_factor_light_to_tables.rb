class AddFactorLightToTables < ActiveRecord::Migration
  def change
    add_column :tables, :factor_light, :float
  end
end
