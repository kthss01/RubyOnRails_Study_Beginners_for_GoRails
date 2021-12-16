class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        # render plain: "Thanks!"
        # render plain: params[:user]

        # params
        # => {"authenticity_token"=>"[FILTERED]", "user"=>{"email"=>"kthtim0704@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}, "commit"=>"Sign Up"}
        # params[:user]
        # => {"email"=>"kthtim0704@gmail.com", "password"=>"[FILTERED]", "password_confirmation"=>"[FILTERED]"}

        # @user = User.new(params[:user])
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Successfully created account"
        else
            # flash[:alert] = "Something was wrong" # 이렇게 안해도 forms에서 알아서 에러 뜸
            render :new # registrations/new view 말하는거
        end
    end

    def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
