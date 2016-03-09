class SessionController < ApplicationController
	#建立session的动作跳过过滤器，但是删除session的动作不跳过，防止用户session被恶意删除。
	skip_before_action :identify, only: [:create]
	#用户登录验证，验证通过后建立session。
	def create
		@user = User.where(params_user)
		if @user
			session[:user_id] = @user.ids
			render json: {code: 0, user: @user}
		else
			render json: {code: 3001}
		end
	end
	
	#用户请求退出，触发后删除session。
	def destroy
		session[:user_id] = nil
		render json: {code: 0}
	end
	#设置参数白名单。
	private
		def params_user
			params.permit(:username, :password)
		end
end