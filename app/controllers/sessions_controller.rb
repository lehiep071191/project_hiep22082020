class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email:params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		login user
  		redirect_to	root_url
  	else
  		flash[:danger] = 'xin kiểm tra lại mật khẩu hoặc tài khoản đăng nhập'
  		render 'new'
  	end	
  end	

  def destroy 
  		log_out
		redirect_to root_url
  end	
end
