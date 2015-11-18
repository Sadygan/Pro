class TableSpecification < Table
  # include ActiveModel::Validations
  
  default_scope { order(:group => :ASC) }

  validates_presence_of :product
  validates :unit_price_factory, presence: true, numericality: true, on: :update
  validates :increment_discount, presence: true, numericality: true, on: :update
  validates :unit_v, numericality: true
  validates :width, numericality: true
  validates :height, numericality: true
  validates :depth, numericality: true
  validates :number_of, presence: true, numericality: { only_integer: true }
  validates :interest_percent, presence: true, numericality: { only_integer: true }
  validates :arhitec_percent, presence: true, numericality: { only_integer: true }
  validates :additional_delivery, presence: true, numericality: true
  # validates :group, numericality: { only_integer: true }
  
  before_save :default_values
  def default_values
    self.unit_v ||= 0
    self.width ||= 0
    self.height ||= 0
    self.depth ||= 0
  end

  # def initialize
  #   @table_specification = table_specification
  #   @percent = table_specification.discount.percent
  #   @additional_discount = table_specification.additional_discount
  # end
  def calculate_percent_bank_delivery summa_netto, cost, execution_document, check_factory,  bank_service, bank_percent, v_sum, additional_deliver
    summa_netto+bank_service+(summa_netto+bank_service)*bank_percent/100+execution_document+check_factory+(cost+additional_deliver)*v_sum
  end

  def unit_price_netto percent, upf, add_discount, incr_discount
    d1 = calculatePercentMinus(upf, percent)
    d2 = calculatePercentMinus(d1, add_discount)
    calculatePercentPlus(d2, incr_discount)
  end

  def calculatingSize
    v = width*height*depth
    v = (v*percent_v/100)+v
    v.round(2)
  end
 
  def upn
    unit_price_netto(discount.percent, unit_price_factory, product.factory.additional_discount, increment_discount).round(2)
  end
  
  def v_sum
    if width != 0 && height !=0 && depth !=0 && percent_v !=0
      multiplication(calculatingSize, number_of).round(2)
    else
      multiplication(unit_v, number_of).round(2)
    end  
  end


  def price_from_nil
    calculate_percent_bank_delivery(summ_netto, delivery.cost, delivery.execution_document, delivery.check_factory,  delivery.bank_service, delivery.bank_percent, v_sum, additional_delivery).round(2)
  end

  def factor
    devision(with_interest, summ_netto).round(2)
  end

  def unit_price
    multiplication(factor, upn).round(2)
  end

  def summa
    multiplication(factor, summ_netto).round(2)
  end

  def group_sum gr
    TableSpecification.where(specification_id: self.specification).where(group: gr).sum(:unit_price_factory)
    # return table_specifications.where(group: gr)
  end

  # Calculate Group
  def groupDataSum gr, col
    group = TableSpecification.where(specification_id: self.specification).where(group: gr)
    ln = group.length-1

    # Unit Price Netto
    unit_price_factory_group_arr = group.pluck(:unit_price_factory)
    
    # Count of goods
    number_of_group = group.pluck(:number_of)
    
    # DISCOUNTS
    group_discount_id_arr = group.pluck(:discount_id)
    
    # Main percent discount
    group_percents = Discount.where(id: group_discount_id_arr)
    group_percents_arr = []
    
    group.each do |i|
      group_percents_arr.push(Discount.find(i.discount_id).percent)
    end
    
    # Additional discount_id
    group_additional_discounts = Factory.where(id: group)

    # Additional discount 
    add_discount = []
    group.each do |i|
      temp = Product.find(i.product).factory.additional_discount
      if (add_discount.nil?)
        temp = 0
      end
     add_discount.push(temp.to_f)
    end

    # Unit V
    unit_v_arr_all = group.pluck(:unit_v)
    unit_v_arr = []
    # width
    width_arr = group.pluck(:width)
    # height
    height_arr = group.pluck(:height)
    # depth
    depth_arr = group.pluck(:depth)
    # percent_v
    percent_v_arr = group.pluck(:percent_v)

    # Adding array to main Unit V group
    for index in 0..ln
      unless width_arr[index] != 0 && height_arr[index] != 0 && depth_arr[index] != 0 && percent_v_arr[index] != 0
        unit_v_arr.push(unit_v_arr_all[index])
      else
        v = width_arr[index] * height_arr[index] * depth_arr[index]
        unit_v_arr.push((v*percent_v/100)+v)
      end
    end

    # Increment Discount
    group_increment_discount_arr = group.pluck(:increment_discount)

    # Number of
    number_of_arr = group.pluck(:number_of)    

    # Delivery
    group_delivery_arr = group.pluck(:delivery_id)
    delivery_arr = []
    for index in 0..ln
      delivery_arr.push(Delivery.find(group_delivery_arr[index]))
    end

    # Interest percent
    interest_percent_arr = group.pluck(:interest_percent)

    # Arhitector percent
    architector_percent_arr = group.pluck(:arhitec_percent)

    # Additional delivery
    additional_delivery_arr = group.pluck(:additional_delivery)

    # Percent V
    percent_v_arr = group.pluck(:percent_v)

    # Object table specification group
    data_group = {  unit_price_factory:  unit_price_factory_group_arr, 
                    number_of:           number_of_group, 
                    percent:             group_percents_arr,
                    additional_discount: add_discount, 
                    increment_discount:  group_increment_discount_arr,
                    unit_v:              unit_v_arr,
                    width:               width_arr,
                    height:              height_arr,
                    depth:               depth_arr,
                    percent_v:           percent_v_arr,
                    delivery:            delivery_arr,
                    interest_percent:    interest_percent_arr,
                    architector_percent: architector_percent_arr,
                    additional_delivery: additional_delivery_arr  
    }

    if (col == "netto")
      return group_netto(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
    elsif (col == "sum_netto")
      return group_sum_netto(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
    elsif (col == "sum_v")
      return group_sum_v(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
    
    elsif (col == "gp_unit_sum")
      return gp_unit_sum(data_group, ln)
    elsif (col == "gp_sum_number")
      return gp_sum_number(data_group, ln)

    elsif (col == "factor")
      return group_factor(data_group, ln)
    elsif (col == "number_of")
      return number_of_arr.inject(0){ |result, elem| result + elem }.round(2)
    elsif (col == "percent_of_number")
      return unit_price_with_percent(data_group, ln)
    elsif (col == "interest_percent")
      return group_first_interest_percent(data_group, ln)
    
    elsif (col == "with_interest")
      return group_with_interest(data_group, ln)
    
    elsif (col == "from_nil_sum")
      return group_unit_price_nil(data_group, ln)
    elsif (col == "interest")
      return group_interest(data_group, ln)
    elsif (col == "architector_percent")
      return group_architector_percent(data_group)    
    elsif (col == "architector_interest")
      return group_architector_interest(data_group, ln)
    elsif (col == "architector_interest_from_order")
      return group_architector_interest_from_order(data_group, ln)
    elsif (col == "additional_delivery")
      return group_additional_delivery(data_group)
    elsif (col == "sum")
      return group_sum_(data_group, ln) 
    end
  
  end

  def group_netto data_group, ln
    unit_price_netto_group_arr = []

    unit_price_factory_arr = data_group[:unit_price_factory]
    percent_arr = data_group[:percent]
    additional_discount_arr = data_group[:additional_discount]
    increment_discount_arr = data_group[:increment_discount]

    for index in 0..ln
      unit_price_netto_group_arr.push(unit_price_netto(percent_arr[index], unit_price_factory_arr[index], additional_discount_arr[index], increment_discount_arr[index]))
    end

    return unit_price_netto_group_arr
  end

  def group_sum_netto data_group, ln
    number_of_arr = data_group[:number_of]
    unit_price_netto_group_arr = group_netto(data_group, ln) 
    sum_price_netto = []

    for index in 0..ln
      sum_price_netto.push(unit_price_netto_group_arr[index] * number_of_arr[index])
    end
    return sum_price_netto
  end

  def group_sum_v data_group, ln
    unit_v = data_group[:unit_v]
    number_of_arr = data_group[:number_of]
    sum_v = []    
    
    for index in 0..ln
      sum_v.push(unit_v[index] * number_of_arr[index])
    end
    
    return sum_v
  end

  def unit_price_with_delivery_nil data_group, ln
    upg_nil = (group_first_price_from_nil_sum(data_group, ln)/100)*percent_of_number(data_group, ln)
    upg_nil.round(2)
  end

  def unit_price_with_percent data_group, ln
    interest_percent = data_group[:interest_percent].last
    a = unit_price_with_delivery_nil(data_group, ln)
    (a*100/(100-interest_percent)).round(2)
  end

  def group_factor data_group, ln
    (unit_price_with_percent(data_group, ln)/unit_price_with_delivery_nil(data_group, ln)).round(2)
  end
# ///
#   def v_sum
#     if width != 0 && height !=0 && depth !=0 && percent_v !=0
#       multiplication(calculatingSize, number_of).round(2)
#     else
#       multiplication(unit_v, number_of).round(2)
#     end  
#   end
# ///

  def arr_sum_v data_group, ln
    number_of_arr = data_group[:number_of]
    unit_v_arr = data_group[:unit_v]
    width_arr = data_group[:width]
    height_arr = data_group[:height]
    depth_arr = data_group[:depth]
    percent_v_arr = data_group[:percent_v]

    arr = []
    for index in 0..ln
      if width_arr[index] != 0 && height_arr[index] !=0 && depth_arr[index] !=0 && percent_v_arr[index] !=0
        arr.push(multiplication(calculatingSize_arr(width_arr[index],height_arr[index],depth_arr[index], percent_v_arr[index]), number_of_arr[index]).round(2))
      else
        arr.push(multiplication(unit_v_arr[index], number_of_arr[index]).round(2))
      end
    end
    arr
  end
  
  def calculatingSize_arr(width,height,depth, percent_v)
    v = width*height*depth
    v = (v*percent_v/100)+v
    v.round(2)
  end

  def group_percent_sum_netto data_group, ln
    arr = []
    gsv = group_sum_v(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
    arr_sum_v(data_group, ln).each do |i|
      # arr.push(i / group_sum_v(data_group, ln)*100)
      arr.push((i / gsv)*100)
    end
    arr
  end

  def group_first_price_from_nil_sum data_group, ln
    group_sum = group_sum_netto(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
    v_sum = group_sum_v(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
    
    cost = data_group[:delivery].last.cost
    execution_document = data_group[:delivery].last.execution_document
    check_factory = data_group[:delivery].last.check_factory
    bank_service = data_group[:delivery].last.bank_service
    bank_percent = data_group[:delivery].last.bank_percent
    additional_delivery = data_group[:additional_delivery].last

    calculate_percent_bank_delivery(group_sum, cost, execution_document, check_factory,  bank_service, bank_percent, v_sum, additional_delivery).round(2)
  end

  def group_unit_price_from_nil data_group, ln
    gpsn_arr = group_percent_sum_netto(data_group, ln)
    gfpfn = group_first_price_from_nil_sum(data_group, ln)
    
    arr = []
    for index in 0..ln
      arr.push(gfpfn/100*gpsn_arr[index])
    end
  arr

  end

  def group_unit_price_nil data_group, ln
    group_unit_price_from_nil(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
  end

  def group_first_interest_percent data_group, ln 
    data_group[:interest_percent].last
  end

  def group_with_interest data_group, ln
    intrest_percent = group_first_interest_percent(data_group, ln)
    gp = group_unit_price_from_nil( data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
    our_interest(gp, intrest_percent).round(2)
  end

  def group_unit_with_interest data_group, ln
    group_with_interest = group_with_interest(data_group, ln)

  end

  def group_interest data_group, ln
    with_interest = group_with_interest(data_group, ln)
    price_from_nil = group_first_price_from_nil_sum(data_group, ln)
    minus(with_interest, price_from_nil).round(2)
  end

  def group_architector_percent data_group
    data_group[:architector_percent].last
  end

  def group_architector_interest data_group, ln
    interest = group_interest(data_group, ln)
    architect_percent = group_architector_percent(data_group)
    calculatePercentMinus(interest, arhitec_percent).round(2)
  end

  def group_architector_interest_from_order data_group, ln
    with_interest = group_with_interest(data_group, ln)
    architector_interest = group_architector_interest(data_group, ln)
    architector_percent(with_interest, architector_interest).round(2)
  end

  def group_additional_delivery data_group
    additional_delivery = data_group[:additional_delivery].last
  end

  def group_sum_ data_group, ln 
    price_from_nil = group_first_price_from_nil_sum(data_group, ln)
    intrest_percent = group_first_interest_percent(data_group, ln)
    our_interest(price_from_nil, interest_percent).round(2)
  end

  # def group_factor data_group, ln
  #   gwi = group_with_interest(data_group, ln)
  #   gsn = group_sum_netto(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
  #   devision(gwi, gsn).round(2)
  # end

  # Percent of number from unit netto
  def percent_of_number data_group, ln
    sum_netto = group_sum_netto(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
    sum_netto_ = sum_netto
    upn_ = upn
    (upn_/sum_netto_*100).round(2)
  end

  # ALL SUM GROUP
  def gp_sum_netto data_group, ln
    # group_netto(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
    number_of = data_group[:number_of]
    unit_price_factory = data_group[:unit_price_factory]

    arr = []
    for index in 0..ln
      arr.push(number_of[index] * unit_price_factory[index])
    end
    arr.inject(0){ |result, elem| result + elem }.round(2)
  end
  
  # -----
  def gp_sum_netto data_group, ln
    # group_netto(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
    number_of = data_group[:number_of]
    unit_price_factory = data_group[:unit_price_factory]

    arr = []
    for index in 0..ln
      arr.push(unit_price_factory[index] * unit_price_factory[index])
    end
    arr.inject(0){ |result, elem| result + elem }.round(2)
  end

  #-----------

  def gp_v_sum data_group, ln
    group_sum_v(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
  end

  def gp_sum_nil data_group, ln
    gp_sum_netto = group_sum_netto(data_group, ln).inject(0){ |result, elem| result + elem }.round(2)
    gp_v_sum = gp_v_sum(data_group, ln)
    
    cost = data_group[:delivery].last.cost
    execution_document = data_group[:delivery].last.execution_document
    check_factory = data_group[:delivery].last.check_factory
    bank_service = data_group[:delivery].last.bank_service
    bank_percent = data_group[:delivery].last.bank_percent
    additional_delivery = data_group[:additional_delivery].last

    calculate_percent_bank_delivery(gp_sum_netto, cost, execution_document, check_factory,  bank_service, bank_percent, gp_v_sum, additional_delivery).round(2)
  end

  def gp_sum_with_interest data_group, ln
    interest_percent = data_group[:interest_percent].last
    gp_sum_nil = gp_sum_nil(data_group, ln)
    our_interest(gp_sum_nil, interest_percent).round(2)
  end

  def gp_unit_sum data_group, ln
    percent_of_number = percent_of_number(data_group, ln)
    gp_sum_with_interest = gp_sum_with_interest(data_group, ln)
    
    (gp_sum_with_interest / 100 * percent_of_number).round(2)
    # group_sum_netto data_group, ln
  end

  def gp_sum_number data_group, ln
    gp_unit_sum = (gp_unit_sum(data_group, ln)).to_f
    (gp_unit_sum * number_of).round(2)
    
  end


  def self.specification_sum_all(specification)
    no_group_sum = 0
    group_sum = 0
    g = []
    table_specifications = TableSpecification.where(specification_id: specification)
    
    j = 0
    table_specifications.each do |i|
      if i.group.nil?
        no_group_sum += i.with_interest
      end
      if !i.group.nil?
        j = j + 1
      if i.add_row(specification)[i.group] >= 1 
        if i.add_row(specification)[i.group] == j
        group_sum += i.groupDataSum(i.group, "sum")
        g.push(i.groupDataSum(i.group, "sum"))
        j = 0
        end
      end
    end

    end
    (group_sum+no_group_sum).round(2)
  end

end
