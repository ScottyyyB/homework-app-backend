class Api::V1::UsersController < ApiController
  def create
  	user = User.new(user_params)
  	if user.save
  	  render json: { token: user.auth_token, username: user.username }, status: 200
  	else
  	  render json: { errors: user.errors.full_messages }, status: 422
  	end
  end

  def index
    users = User.all.select { |user| user[params[:type]] }
    render json: users, each_serializer: UserIndexSerializer,
           status: 200
  end

  private

  def user_params
  	params.require(:user).permit(:username, :email, :password)
  end
end
