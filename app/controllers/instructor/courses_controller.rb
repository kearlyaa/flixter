class Instructor::CoursesController < ApplicationController
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show, :delete]

  def new
    @course = Course.new
  end

  def create
    @course = current_user.courses.create(course_params)
    if @course.valid?
      redirect_to instructor_course_path(@course)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @section = Section.new
    @lesson = Lesson.new
  end

  def destroy
    current_course.destroy
    redirect_to courses_path
  end

  private

  def require_authorized_for_current_course
    if current_course.user != current_user
      render text: "Unauthorized", status: :unauthorized
    end
  end

  helper_method :current_course
  def current_course
    @current_course ||= Course.find_by_id(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :cost, :image)
  end
end
