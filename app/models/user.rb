class User < ActiveRecord::Base
  attr_accessor :delete_avatar
  belongs_to :community
  has_many :items, :foreign_key => 'seller_id'

  validates :name, presence: true, format: { 
    with: /[a-zA-Z\s]/,
    message: "only allows letters and spaces"
  }

  validates :email, presence: true, format: {
    with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: "must be proper email format"
  }
  
  has_secure_password

  before_validation {avatar.clear if delete_avatar =='1'}

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ActionController::Base.helpers.asset_path('placeholder-avatar.png')
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
end
