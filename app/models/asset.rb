class Asset < ActiveRecord::Base
  	belongs_to :product
  	has_one :table_specification
  	# accepts_nested_attributes_for :table_specifications

  	# has_attached_file :img, 
		 #   			  :default_url => "/images/original/missing.png",
	  #                 :styles=>{:medium => "600x600>", :thumb => "300x300>"},
	  #   	   		  :path => ":rails_root/public/photos/product/:product_article/:class/:filename",
	  #   			  :url  => "/photos/product/:product_article/:class/:filename"

	has_attached_file :img,
				      :storage => :dropbox,
				      :dropbox_credentials => Rails.root.join("config/dropbox.yml"),
				      :path => "product/:product_article/:class/:filename"
	
	validates_attachment_content_type :img, :content_type => %w(image/jpeg image/jpg image/png)

	Paperclip.interpolates :class do |attachment, style|
	  attachment.instance.class
	end

	Paperclip.interpolates :product_article  do |attachment, style|
	  attachment.instance.product.article
	end

	# Get path url current image 
	def img_url
      img.url
 	end
end
