class ChangeDeliveryFromCost < ActiveRecord::Migration
  def change
	    change_column :deliveries, :cost,  :float
  	end
end
