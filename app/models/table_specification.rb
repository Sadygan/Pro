class TableSpecification < ActiveRecord::Base
  include ActiveModel::Validations
  
  belongs_to :specification
  belongs_to :discount
  belongs_to :factory
  belongs_to :delivery
  belongs_to :product
  belongs_to :photo

  default_scope { order(:group => :ASC) }

  # def initialize
  #   @table_specification = table_specification
  #   @percent = table_specification.discount.percent
  #   @additional_discount = table_specification.additional_discount
  # end
  
  def add_row specification
    # ar = specification.table_specifications.pluck(:group)
    ar = TableSpecification.where(specification_id: specification).pluck(:group)
    h = Hash.new(0)
    ar.each{ | v | h.store(v, h[v]+1)}
    h
  end

  def multiplication a, b
    a * b
  end

  def calculatePercentMinus a, b
    a = a.to_f
    b = b.to_f
    a - (a / 100 * b)
  end

  def calculatePercentPlus a, b
    a = a.to_f
    b = b.to_f
    a + (a / 100 * b)
  end

  def minus a, b
    a - b
  end


  def calculate_percent_bank_delivery summa_netto, cost, execution_document, check_factory,  bank_service, bank_percent, v_sum, additional_deliver
    summa_netto+bank_service+(summa_netto+bank_service)*bank_percent/100+execution_document+check_factory+(cost+additional_deliver)*v_sum
  end

  def unit_price_netto percent, upf, add_discount, incr_discount
    d1 = calculatePercentMinus(upf, percent)
    d2 = calculatePercentMinus(d1, add_discount)
    calculatePercentPlus(d2, incr_discount)
  end

  def our_interest summ_netto, percent
    summ_netto*100/(100-percent)
  end

  def devision with_interest, summa_netto
    with_interest/summa_netto
  end


  def architector_percent with_interest, architector
    100-(with_interest-architector)/with_interest*100
  end
  
  
  def calculatingSize
    v = width*height*depth
    v = (v*percent_v/100)+v
    v.round(2)
  end

  def upn
    unit_price_netto(discount.percent, unit_price_factory, product.factory.additional_discount, increment_discount).round(2)
  end
  
  def summ_netto
    multiplication(upn, number_of).round(2)
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

  def with_interest
    our_interest(price_from_nil, interest_percent).round(2)
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

  def interest
    minus(with_interest, price_from_nil).round(2)
  end

  def architector_interest
    calculatePercentMinus(interest, arhitec_percent).round(2)
  end

  def architector_percent_from_order
    architector_percent(with_interest, architector_interest).round(2)
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
    elsif (col == "number_of")
      return number_of_arr.inject(0){ |result, elem| result + elem }.round(2)
    elsif (col == "from_nil_sum")
      return group_first_price_from_nil_sum(data_group, ln)
    elsif (col == "interest_percent")
      return group_first_interest_percent(data_group, ln)
    elsif (col == "with_interest")
      return group_with_interest(data_group, ln)
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

  def group_first_interest_percent data_group, ln 
    data_group[:interest_percent].last
  end

  def group_with_interest data_group, ln
    intrest_percent = group_first_interest_percent(data_group, ln)
    price_from_nil = group_first_price_from_nil_sum(data_group, ln)
    our_interest(price_from_nil, interest_percent).round(2)
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

  def self.specification_sum_all(specification)
    no_group_sum = 0
    group_sum = 0
    g = []
    table_specifications = TableSpecification.where(specification_id: specification)
    
    # specification.
    # unless group.nil?
    # else
      # return specification.table_specifications
    # end
    j = 0
    table_specifications.each do |i|
      if i.group.nil?
        no_group_sum += i.summa
      end
      if !i.group.nil?
        j = j + 1
      if i.add_row(specification)[i.group] >= 1 
        if i.add_row(specification)[i.group] == j
        group_sum += i.groupDataSum(i.group, "with_interest")
        g.push(i.groupDataSum(i.group, "sum"))
        j = 0
        end
      end
    end

    end
    (group_sum+no_group_sum).round(2)
    # specification.group_sum_ ()
  end

 # Select image in form
  def image id 
    if id.nil? || id == 0
      "/no_image/no_image.png"
    else
      Asset.find(id).img.url
    end
  end

  def photo_select id
    Photo.where(product_id: id)
  end

  def size_image_select id
    SizeImage.where(product_id: id)
  end
 # ----


end
