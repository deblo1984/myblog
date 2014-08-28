class Admin::ProfilesController < ApplicationController	
	#before_action :set_profiles, only: [:show, :edit, :update, :destroy]
	before_filter :authenticate_user!

  	def show
      @profile = current_user.profile
      #@profile = @user.profile.find(params[:profile_id])

  	end

  	def edit
  		@profile = current_user.profile
  	end

  	def update
  		@profile = current_user.profile
  		respond_to do |format|
    		if @profile.update(profile_params)
        		format.html { redirect_to ([:admin,@profile]), notice: 'Category was successfully updated.' }
        		format.json { render :show, status: :ok, location: ([:admin, @profile]) }
     		else
        		format.html { render :edit }
        		format.json { render json: @profile.errors, status: :unprocessable_entity }
      		end
    	end
  	end

  	def destroy
  		@profile.destroy
  		respond_to do |format|
  			format.html {redirect_to admin_categories_url, notice: 'Profile Successfully destroy'}
  			format.json { head :no_content }
  		end
  	end

  	private 
  		def set_profiles
  			@user = current_user
    		@profile = @user.profile.find(params[:profile_id])
  		end

  		def profile_params
  			params.require(:profile).permit(:first_name, :last_name, :description, :avatar)
  		end
end
