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

  # def factory_brand
  # 	factory.try(:brand)
  # end

  # def factory_brand=(brand)
  # 	self.factory = Factory.find_by_name(brand) if brand.present?
  # end

end
