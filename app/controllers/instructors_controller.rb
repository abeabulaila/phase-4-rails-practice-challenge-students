class InstructorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  def index
    render json: Instructor.all
  end

  def create
    instructor = Instructor.create!(instructor_params)
    render json: instructor, status: :created
  end

  def show
    instructor = Instructor.find(params[:id])
    render json: instructor
  end

  def update
  instructor = Instructor.find(params[:id])
  instructor.update!(instructor_params)
  render json: instructor
  end

  def destroy
  instructor = Instructor.find(params[:id])
  instructor.destroy
  head :no_content
  end

  private

  def instructor_params
    params.permit(:name)
  end

  def record_not_found(e)
    render json: { error: e.message }, status: :not_found
  end

  def invalid_record(e)
    render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
  end
end
