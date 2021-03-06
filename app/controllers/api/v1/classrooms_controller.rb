class Api::V1::ClassroomsController < ApiController
  before_action :require_login
  before_action :classroom, only: [:destroy, :update, :show]

  def create
  	classroom = current_user.classrooms.new(classroom_params)
  	if classroom.save
      render status: 200
    else
  	   render json: { errors: classroom.errors.full_messages},
              status: 422
  	end
  end

  def destroy
    @classroom.students.each { |student| student.delete }
    @classroom.delete
    render status: 200
  end

  def update
    if @classroom.update(classroom_params) 
      render status: 200
    else
       render json: { errors: @classroom.errors.full_messages},
              status: 422
    end
  end

  def index
    if current_user.student
      classrooms = []
      Student.where(:user_id => current_user.id).each do |student|
        classrooms << student.classroom
      end
      render json: classrooms, each_serializer: ClassroomSerializer
    else
      classrooms = current_user.classrooms
      render json: classrooms, each_serializer: ClassroomSerializer
    end
  end

  def show
    render json: @classroom, serializer: ClassroomShowSerializer
  end

  private

  def classroom_params 
    params.require(:classroom).permit!
  end

  def classroom
    @classroom = Classroom.find(params[:id])
  end
end
