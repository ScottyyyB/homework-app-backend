class Api::V1::ClassroomController < ApplicationController
  before_action :authenticate_api_v1_user!

  def create
  	classroom = current_api_v1_user.classrooms.new(classroom_params)
  	if classroom.save
      render status: 200
    else
  	   render json: { errors: classroom.errors.full_messages},
              status: 422
  	end
  end

  def destroy
    classroom = Classroom.find(params[:id])
    classroom.students.each { |student| student.delete }
    classroom.delete
    render status: 200
  end

  def update
    classroom = Classroom.find(params[:id])
    if classroom.update(classroom_params) 
      render status: 200
    else
       render json: { errors: classroom.errors.full_messages},
              status: 422
    end
  end

  def index
    if current_api_v1_user.student
      classrooms = []
      Student.where(:user_id => current_api_v1_user.id).each do |student|
        classrooms << student.classroom
      end
      render json: classrooms, each_serializer: ClassroomSerializer
    else
      classrooms = current_api_v1_user.classrooms
      render json: classrooms, each_serializer: ClassroomSerializer
    end
  end

  private

  def classroom_params 
    params.require(:classroom).permit!
  end
end
