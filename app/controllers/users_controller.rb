class UsersController < ApplicationController
	before_action :logged_in_user, only: [:index, :edit, :update]
	before_action :check_login, only: :new
	before_action :find_id, only: [:show, :edit, :correct_user, :destroy]
	before_action :correct_user, only: [:edit, :update]
	before_action :admin_user, only: :destroy
  
	def index
		@users = User.paginate page: params[:page]
	end	

	def show
		@microposts = @user.microposts.paginate(page: params[:page])
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
  		@user.destroy
		flash[:success] = "User deleted"
		redirect_to users_url
 	end

 	def edit
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:success] = "Profile updated"
			redirect_to @user
		# Handle a successful update.
		else
			render 'edit'
		end
	end

  	private 

  	def logged_in_user
		unless logged_in?
			store_location
			flash[:danger] = "Please log in."
			redirect_to login_url
		end
	end

	def check_login
		if logged_in?
			flash[:danger] = "Bạn đã đăng nhập!!!!"
		end	
	end		

  	def find_id
  		@user = User.find_by(id:params[:id])
  		if @user.nil?
  			flash[:danger] = "tài khoản không khả dụng"
  			redirect_to	root_url
  		end	
  	end	

  	def correct_user
  		@user = User.find_by(id:params[:id])
		redirect_to(root_url) unless current_user.current_user?(@user)
	end

  	def user_params
  		params.require(:user).permit(:name, :email, :password, :password_confirmation, :ngaysinh, :diachi, :gioitinh)
  	end	

  	def admin_user
		redirect_to(root_url) unless current_user.admin?
	end
end
