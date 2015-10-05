class TableSpecification < ActiveRecord::Base
  include ActiveModel::Validations
  belongs_to :specification
  belongs_to :discount
  belongs_to :factory
  belongs_to :delivery

  has_attached_file :image, 
    	   			  :default_url => "/images/original/missing.png",
                :styles=>{:medium => "600x600>", :thumb => "300x300>"},
    	   			  :path => ":rails_root/public/images/:id/:filename",
    				    :url  => "/images/:id/:filename"

  has_attached_file :size_image, 
              :default_url => "",
              :styles=>{:medium => "600x600>", :thumb => "300x300>"},
              :path => ":rails_root/public/images/size_image/:id/:filename",
              :url  => "/images/size_image/:id/:filename"
                
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :article
  validates_length_of :article, maximum: 20, minimum: 4

  # def initialize
  #   @table_specification = table_specification
  #   @percent = table_specification.discount.percent
  #   @additional_discount = table_specification.additional_discount
  # end 

  def calculatingSize
    v = width*height*depth
    (v*percent_v/100)+v 
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

  def minus a, b
    a - b
  end

  def architector_percent with_interest, architector
    100-(with_interest-architector)/with_interest*100
  end



  def upn
    unit_price_netto(discount.percent, unit_price_factory, factory.additional_discount, increment_discount).round(2)
  end
  
  def summ_netto
    multiplication(upn, number_of)
  end

  def v_sum
    if width != 0 && height !=0 && depth !=0 && percent_v !=0
      multiplication(calculatingSize, number_of)
    else
      multiplication(unit_v, number_of)
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
  # def with_interest
  #   our_interest(price_at_nil, interest_percent);
  # end
end
