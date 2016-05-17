class ChangeFactorFromDiscountLight < ActiveRecord::Migration
  def change
	    change_column :discount_lights, :factor,  :float
  end
end
