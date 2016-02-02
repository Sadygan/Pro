class TableSpecificationLight < Table
  
  # validates :unit_price_factory, presence: true, numericality: true
  # validates :number_of, presence: true, numericality: {only_integer: true}
  # validates :interest_percent, presence: true, numericality: { only_integer: true }
  # validates :arhitec_percent, presence: true, numericality: { only_integer: true }

  def upn
  	unit_price_factory
  end

  def unit_price_factor
  	multiplication(unit_price_factory, product.brand_model.factory.light_factor)
  end

  def price_from_nil
  	multiplication(unit_price_factor, number_of)
  end

  def unit_with_interest_light
    with_interest/number_of
  end

  def self.specification_sum_all(specification, arg)
  	table_specification_lights = TableSpecificationLight.where(specification_id: specification)
  	sum = 0

  	table_specification_lights.each do |i|
  		sum += i.with_interest
  	end
  sum
  end

end
