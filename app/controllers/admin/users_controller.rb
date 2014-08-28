class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:destroy, :edit, :update]
  before_filter :authenticate_user!

  def index
  	@users = User.all.page(params[:page]).per(10)
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)

  	respond_to do |format|
  		if @user.save
  			format.html { redirect_to admin_users_path, notice: 'User has been added'}
  			format.json { render :show, status: :created, location: @user }
  		else
  			format.html { render :new }
  			format.json { render json: @user.errors, status: :unprocessable_entity }
  		end
  	end
  end

  def edit
  end

  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(devise_parameter_sanitizer.sanitize(:account_update))
    else
      # remove the virtual current_password attribute
      # update_without_password doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    end

    if successfully_updated
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to admin_users_path
    else
      render "edit"
    end
  end

  def destroy
  	@user.destroy
  	respond_to do |format|
  		format.html { redirect_to admin_users_path, notice: 'Users has been destroy' }
  		format.json { head :no_content}
  	end
  end

  private
  	def set_user
  		@user = User.find(params[:id])
  	end

  	def user_params
  		params.require(:user).permit(:email, :password, :password_confirmation)
  	end

    def needs_password?(user, params)
    user.email != params[:user][:email] ||
      params[:user][:password].present? ||
      params[:user][:password_confirmation].present?
  end

end
