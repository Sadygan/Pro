class Table < ActiveRecord::Base
  belongs_to :specification
  belongs_to :discount
  belongs_to :factory
  belongs_to :delivery
  belongs_to :product
  belongs_to :photo

  attr_accessor :photo_base64, :photo_base64_form, :size_image_base64, :size_image_base64_form, :ts_id

  default_scope { order(:order => :ASC) }
  
  def add_row specification
    # ar = specification.table_specifications.pluck(:group)
    ar = TableSpecification.where(specification_id: specification).pluck(:group)
    h = Hash.new(0)
    ar.each{ | v | h.store(v, h[v]+1)}
    h.delete(nil)
    p "=====>"
    p h
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

  def our_interest summ_netto, percent
    summ_netto*100/(100-percent)
  end

  def devision with_interest, summa_netto
    with_interest/summa_netto
  end

  def architector_percent with_interest, architector
    100-(with_interest-architector)/with_interest*100
  end
# --- calculate
  def summ_netto
    multiplication(upn, number_of).round(2)
  end

  def with_interest
    our_interest(price_from_nil, interest_percent).round(2)
  end

  def interest
    minus(with_interest, price_from_nil).round(2)
  end

  def company_interest
    calculatePercentMinus(interest, arhitec_percent).round(2)
  end

  def architector_interest
    (interest - company_interest).round(2)
  end

  def architector_percent_from_order
    architector_percent(with_interest, architector_interest).round(2)
  end

# Select image in form
  def image id 
    if id.nil? || id == 0
      "/no_image/no_image.png"
    else
      Asset.find(id).img.url(:original)
    end
  end


  def photo_select id
    Photo.where(product_id: id)
  end

  def size_image_select id
    SizeImage.where(product_id: id)
  end
  # ----
  
  # PDF
  def image_pdf id 
    unless id.nil? || id == 0 
      Asset.find(id).img.url(:thumb).gsub('https', 'http')
    end
  end

  def total_price
    total_sum = []
    if @specification.print_sum
      if @specification.light
        total_sum = [[{colspan: 5}, "Сумма", {content: "#{TableSpecificationLight::specification_sum_all(@specification, "sum")}"}]]
      else
        total_sum = [[{colspan: 5}, "Сумма", {content: "#{TableSpecification::specification_sum_all(@specification, "sum")}"}]]
      end
    end
    total_sum
  end
end
