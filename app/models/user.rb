class User < ApplicationRecord
	before_save :email_downcase
	validates :name, length: { maximum: 50 }, presence: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, length: { minimum: 6 }, presence: true, uniqueness: true,
				format: { with: VALID_EMAIL_REGEX }
	has_secure_password
	validates :password, length: { maximum: 20}, presence: true
	validates :password_confirmation, presence: true
	validate :check_date
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
