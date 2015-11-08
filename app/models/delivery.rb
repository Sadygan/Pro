class Delivery < ActiveRecord::Base
	has_many :table_specifications

	accepts_nested_attributes_for :table_specifications

	validates :direction, presence: true, uniqueness: true

  before_save :default_values
  def default_values
    self.cost ||= 0
    self.execution_document ||= 0
    self.check_factory ||= 0
    self.bank_service ||= 0  
    self.bank_percent ||= 0  
  end

end
