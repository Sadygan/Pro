class Asset < ActiveRecord::Base
  	belongs_to :product
  	has_one :table_specification

  	# accepts_nested_attributes_for :table_specifications

  	# has_attached_file :img, 
	  #   	   		  :styles => {:thumb => "40x30", :medium => "400x300"},
	  #   	   		  :path => ":rails_root/public/photos/product/:product_article/:class/:filename",
	  #   			  :url  => "/photos/product/:product_article/:class/:filename"


	has_attached_file :img,
				      :storage => :dropbox,
				      :dropbox_credentials => Rails.root.join("config/dropbox.yml"),

					  styles: {thumb: "190"},
								 
					# :processors => [:papercrop, :rotator],  
				      # :path => "product/:product_article/:class/:filename"
					# :path => "/product/:product_article/:class/:filename"
					:dropbox_options => {       
						path: proc{|style| "image/#{id}/#{style}/#{id}_#{img.original_filename}"}
					}
	validates :img, attachment_presence: true
	validates_attachment_content_type :img, :content_type => %w(image/jpeg image/jpg image/png)

	crop_attached_file :img, :aspect => false
	
	Paperclip.interpolates(:class) do |attachment, style|
	  attachment.instance.class
	end

	Paperclip.interpolates(:product_article)  do |attachment, style|
	  attachment.instance.product.article
	end

	# Get path url current image 
	def img_url
      img.url(:original)
 	end

end
