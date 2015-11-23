class User < ActiveRecord::Base
  rolify
  has_many :factories
  has_many :projects

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, 
		   			:default_url => "/avatars/no_image/no_image.png",
	                :styles=>{:medium => "600x600>", :thumb => "300x300>"},
	    	   		:path => ":rails_root/public/avatars/:filename",
	    			:url  => "/avatars/:filename"
	
	validates_attachment_content_type :avatar, :content_type => %w(image/jpeg image/jpg image/png)

  rolify :before_add => :before_add_method

  def before_add_method(role)
    # do something before it gets added
  end

end
