class Api::V1::ClassroomController < ApplicationController
  def create
  	classroom = current_api_v1_user.classrooms.new(classroom_params)
  	if classroom.save
      render status: 200
    else
      if classroom.errors.first[0] != :user_ids
  	   render json: { errors: classroom.errors.full_messages},
              status: 422
      else
        render json: { errors: classroom.errors.first[1] },
               status: 422
      end
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
      if classroom.errors.first[0] != :user_ids
       render json: { errors: classroom.errors.full_messages},
              status: 422
      else
        render json: { errors: classroom.errors.first[1] },
               status: 422
      end
    end
    binding.pry
  end

  private

  def classroom_params 
    params.require(:classroom).permit!
  end
end
