class Api::V1::UsersController < ApiController
  def create
  	user = User.create(user_params)
  	render json: { token: user.auth_token, username: user.username }
  end

  private

  def user_params
  	params.require(:user).permit(:username, :email, :password)
  end
end
