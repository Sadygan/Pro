class Project < ActiveRecord::Base
  has_many :specifications, dependent: :destroy
  has_many :statuses
  belongs_to :user
  belongs_to :client
  belongs_to :city
  belongs_to :style

  accepts_nested_attributes_for :specifications
  accepts_nested_attributes_for :statuses
  
  before_save :default_values
  def default_values
    self.planned_budget ||= 0
    self.amount_contract ||= 0
    self.client_prepayment ||= 0
    self.client_surcharge ||= 0  
  end

  validates_presence_of :client
  validates_presence_of :city
  validates_presence_of :style

  validates :object_name, presence: true
  validates :type_furniture, presence: true
  validates :planned_budget, numericality: { only_integer: false }, on: :update
  validates :amount_contract, numericality: { only_integer: false }, on: :update
  validates :client_prepayment, numericality: { only_integer: false }, on: :update
  validates :client_surcharge, numericality: { only_integer: false }, on: :update
  validates :deadline, presence: true
  
  # validates :client, presence: true
  
  # Date
  Date::DATE_FORMATS[:default] = "%d-%m-%Y" 

  # Time
  Time::DATE_FORMATS[:default] = "%d/%m/%Y %H:%M" 

  def self.find_table_specifications(ids)
 	  table_specifications = Table.where(specification: ids).all
  end

  def self.find_statuses(ids)
    statuses = Status.where(project: ids).all
  end
  
  def status
    statuses.last.name
  end

  def status_description
    statuses.last.description
  end

  def self.sum_specifications specifications
    # return specifications.ids.length
    spec_arr = []
    
    for index in 0..specifications.ids.length-1 
      spec_arr.push(TableSpecification::specification_sum_all(specifications.ids[index]))
      spec_arr.push(TableSpecificationLight::specification_sum_all(specifications.ids[index]))
    end
    spec_arr.inject(0){ |result, elem| result + elem }.round(2)
  end
  
end
