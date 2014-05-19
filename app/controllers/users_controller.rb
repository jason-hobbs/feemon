class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]
  before_action :get_user

def index    
    @users = User.all
end

def new
	@user=User.new
  @feeds = Feed.all
end

def show
	@user = User.find(params[:id])
end

def create
  		@user = User.new(user_params)
  		if @user.save
		    #session[:user_id] = @user.id
    		redirect_to @user, notice: "Thanks for signing up!"
  		else
    		render :new
  		end 
	end

	def edit
  		@user = User.find(params[:id])
      @feeds = Feed.all
	end

	def update
  	@user = User.find(params[:id])
    @feeds = Feed.all
		if @user.update(user_params)
    	redirect_to @user, notice: "Account successfully updated!"
  	else
    	render :edit
  	end
	end

	def destroy
  		@user = User.find(params[:id])
  		@user.destroy
  		session[:user_id] = nil
  		redirect_to root_url, alert: "Account successfully deleted!"
	end

	private

	def user_params
  	  params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def require_correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
  end

  def get_user
    if session[:user_id]    
      @user = current_user
    end
  end

end
