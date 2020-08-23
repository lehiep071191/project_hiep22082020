class UsersController < ApplicationController
	before_action :find_id, only: :show
  
	def show
	end
	def new
	  	@user = User.new
	 end

  	def create
	  	@user = User.new(user_params)
	  	if @user.save
	  		login @user
		  	flash[:success] = "Welcome to the Sample App!"
		  	redirect_to root_url
	  	else
	  		render :new 
	  	end	
    end

  	def destroy
 	end

  	private 
  	def find_id
  		@user = User.find_by(id:params[:id])
  		if @user.nil?
  			flash[:danger] = "tài khoản không khả dụng"
  			redirect_to	root_url
  		end	
  	end	
  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation, :ngaysinh, :diachi, :gioitinh)
  	end	
end
