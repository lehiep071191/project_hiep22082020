class User < ApplicationRecord
	has_many :microposts, dependent: :destroy
	attr_accessor :remember_token
	before_save :email_downcase
	validates :name, length: { maximum: 50 }, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, length: { minimum: 6 }, presence: true, uniqueness: true,
				format: { with: VALID_EMAIL_REGEX }
	has_secure_password
	validates :password, length: { maximum: 20}, presence: true, allow_nil: true
	validates :password_confirmation, presence: true
	validate :check_date

	# Returns the hash digest of the given string.
	class <<self

		def digest(string)
				cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
				BCrypt::Engine.cost
				BCrypt::Password.create(string, cost: cost)
		end	

		def new_token
			SecureRandom.urlsafe_base64
		end	

	end		
	def remember
		self.remember_token = User.new_token
		update_attributes remember_digest: User.digest(remember_token) 
	end	
	# Returns true if the given token matches the digest.
	def authenticated?(remember_token)
		return false if remember_digest.nil?
		BCrypt::Password.new(remember_digest).is_password?(remember_token)
	end	
	def forget
		update_attributes remember_digest: nil
	end	
	def current_user?(user)
		user && user == self
	end
	def feed
		Micropost.where("user_id = ?", id)
	end
	private 
	def email_downcase
		self.email = email.downcase
	end	
	def check_date
		if ngaysinh && ngaysinh.Date > Date.current?
			add.errors(:ngaysinh, 'ngày sinh không thể lớn hơn ngày hiện tại')	
		end	
	end 
end
