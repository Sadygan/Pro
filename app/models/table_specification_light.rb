class TableSpecificationLight < Table
  
  # validates :unit_price_factory, presence: true, numericality: true
  # validates :number_of, presence: true, numericality: {only_integer: true}
  # validates :interest_percent, presence: true, numericality: { only_integer: true }
  # validates :arhitec_percent, presence: true, numericality: { only_integer: true }
  validates :factor_light, presence: true, length: {maximum: 6}

  def upn
  	unit_price_factory
  end

  def unit_price_factor
    # multiplication(unit_price_factory, product.brand_model.factory.light_factor).round(2)
    if factor_light.nil?
      multiplication(unit_price_factory, product.brand_model.factory.light_factor).round(2)
    else
      multiplication(unit_price_factory, factor_light).round(2)
    end
  end

  def price_from_nil
  	multiplication(unit_price_factor, number_of).round(2)
  end

  def summa
    with_interest.round(2)
  end

  def unit_price
    (with_interest/number_of).round(2)
  end

  def self.specification_sum_all(specification, arg, flag=0)
  	table_specification_lights = TableSpecificationLight.where(specification_id: specification)
  	sum = 0
    selected_sum = 0

  	table_specification_lights.each do |i|
      if arg === "sum"
        if i.required == true
          selected_sum += i.with_interest
        end
        sum += i.with_interest
      end

      if arg === "architector_interest"
        if i.required == true
          selected_sum += i.architector_interest
        end
        sum += i.architector_interest
      end
  	end

    if flag == "selected"
      selected_sum.round(2)
    else
      sum.round(2)
    end
  end

end
