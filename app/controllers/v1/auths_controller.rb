module V1
  class AuthsController < ApplicationController

    def create
      token_command = AuthenticateUserCommand.call(*params.slice(:user, :password).values)

      if token_command.success?
        @user = User.find_by_email(params[:user])
        if @user.type === "Client"
          render json: {
             token: token_command.result,
             type: @user.type,
             user: @user,
             hatchery: @user.info.hatchery,
           }
        else
          render json: {
             token: token_command.result,
             type: @user.type,
             user: @user
           }
         end
      else
        render json: { error: token_command.errors }, status: :unauthorized
      end
    end
  end
end
