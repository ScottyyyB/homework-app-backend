class Api::V1::HomeworkController < ApiController
  before_action :require_login
  
  def create
    homework = []
  	classroom = Classroom.find(params[:homework][:classroom_id])
    classroom.students.each do |student|
      homework << classroom.homework.new(homework_params.merge(user_id: student.user_id))
    end
    if homework.all? { |obj| obj.save }
      render status: 200
    else
      render json: { errors: homework[0].errors.full_messages }
    end
  end

  private

  def homework_params
    params.require(:homework).permit!
  end
end
