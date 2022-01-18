class StudentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

    def index
        render json: Student.all
    end

    def show
        student = find_student
        render json: student
    end

    def create
        student = Student.create!(student_params)
        render json: student, status: :created
    end

    def update
        student = find_student
        student.update!(student_params)
        render json: student
    end

    def destroy
        student = find_student
        student.destroy
        head :no_content
    end




        private 

        def find_student
            student = Student.find(params[:id])
        end

        def student_params
            params.permit(:name, :major, :age, :instructor_id)
        end

        def record_not_found(e)
            render json: {error: e.message}, status: :not_found
        end

        def record_invalid(e)
            render json: {errors: e.record.errors.full_messages}, status: :unprocessable_entity
        end
end
