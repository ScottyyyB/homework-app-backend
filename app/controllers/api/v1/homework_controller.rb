class Api::V1::HomeworkController < ApiController
  before_action :require_login
  before_action :homework, only: [:destroy, :update]
  before_action :classroom
  
  def create
    homework = []
  	@classroom = Classroom.find(params[:classroom_id])
    @classroom.students.each do |student|
      homework << @classroom.homework.new(homework_params.merge(user_id: student.user_id))
    end
    if homework.all? { |obj| obj.save }
      render status: 200
    else
      render json: { errors: homework[0].errors.full_messages },
             status: 422
    end
  end

  def destroy
    @homework.delete and render status: 200
  end

  def update
    if @homework.update(homework_params)
      render status: 200
    else
      render json: { errors: @homework.errors.full_messages },
             status: 422
    end
  end

  def index
    homework = @classroom.homework.select { |obj| obj.status == params[:status] }
    render json: homework, each_serializer: HomeworkSerializer,
           status: 200
  end

  private

  def homework_params
    params.require(:homework).permit!
  end

  def homework
    @homework = Homework.find(params[:id])
  end

  def classroom
    @classroom = Classroom.find(params[:classroom_id])
  end
end
