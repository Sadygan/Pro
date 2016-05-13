class RemoveLightFactoryIdFromFactories < ActiveRecord::Migration
  def change
    remove_column :factories, :light_factory_id, :integer
  end
end
