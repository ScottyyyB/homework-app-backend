class Api::V1::UsersController < ApiController
  def create
  	user = User.new(user_params)
  	if user.save
  	  render json: { token: user.auth_token, name: user.name }, status: 200
  	else
  	  render json: { errors: user.errors.full_messages }, status: 422
  	end
  end

  def index
    users = User.all.select { |user| user[params[:type]] }
    users.sort! { |a, b| [a.grade, a.name[0]] <=> [b.grade, b.name[0]] }
    users.select! { |user| user.grade == params[:grade].to_i } if params[:grade]
    render json: users, each_serializer: UserIndexSerializer,
           status: 200
  end

  private

  def user_params
  	params.require(:user).permit!
  end
end
