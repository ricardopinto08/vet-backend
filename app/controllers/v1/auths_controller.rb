module V1
  class AuthsController < ApplicationController

    def create
      token_command = AuthenticateUserCommand.call(*params.slice(:user, :password).values)

      if token_command.success?
        @user = User.find_by_email(params[:user])
        render json: {
           token: token_command.result,
           type: @user.type,
           user: @user
         }
      else
        render json: { error: token_command.errors }, status: :unauthorized
      end
    end
  end
end
