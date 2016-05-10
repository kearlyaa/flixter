class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :user_enrolled_in_course
  attr_reader :random_image_filename

  def show
    @random_image_filename = ["puppies.jpg", "kittens.jpg", "hippo.jpg"].sample
  end

  private
  
  helper_method :current_lesson
  
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def user_enrolled_in_course
    if !current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path(current_lesson.section.course), alert: 'Please enroll in this course to view lessons'
    end
  end
end

