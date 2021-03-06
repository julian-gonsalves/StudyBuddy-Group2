class StudyGroupsController < ApplicationController
  before_action :authenticate_user!

  def index
    @course = Course.find(params[:course_id])
    @study_groups = @course.study_groups
  end

  def show
    @study_group = StudyGroup.find(params[:id])
    @attendees = @study_group.attendees
  end

  def new
    @course = Course.find(params[:course_id])
  end

  def edit
    @study_group = StudyGroup.find(params[:id])
    @course = Course.find(params[:course_id])
  end

  def create
    course_id = params[:course_id]
    course = Course.find(course_id)
    study_group_params_1 = study_group_params
    study_group_params_1[:user_name] = current_user.name
    study_group_params_1[:course_code] = course.course_code
    study_group_params_1[:course_id] = course_id
    study_group_params_1[:user_id] = current_user.id
    @study_group = StudyGroup.new(study_group_params_1)

    if @study_group.save
      flash[:notice] = "Successfully add a new Study Group"
      redirect_to :action => "show", :id => @study_group.id
    else
      flash.now[:error] = @study_group.errors.full_messages
      render 'new'
    end

  end

  def update
    @study_group = StudyGroup.find(params[:id])

    if @study_group.update(study_group_params)
      redirect_to :action => "show", :id => @study_group
    else
      render 'edit'
    end
  end

  def destroy
    @course = Course.find(params[:course_id])
    @study_group = StudyGroup.find(params[:id])
    study_group_id = params[:study_group_id]

    @attendee = Attendee.where(study_group_id: study_group_id)
    @attendee.where(study_group_id: study_group_id).destroy_all

    if @study_group.destroy
      redirect_to :action => "index"
    else
      @study_group.errors.full_messages
      redirect_to :action => "show", :id => study_group_id
    end
  end

  def attend
    course_id = params[:course_id]
    study_group_id = params[:study_group_id]
    study_group = StudyGroup.find(study_group_id)
    @attendee = Attendee.new(event_name: study_group.event_name, user_name: current_user.name, user_id: current_user.id, study_group_id:study_group_id)

    @attendee.save
    redirect_to :action => "show", :id => study_group_id
  end

  def unattend
    course_id = params[:course_id]
    study_group_id = params[:study_group_id]
    study_group = StudyGroup.find(study_group_id)

    @attendee = Attendee.where(study_group_id: study_group_id, user_id: current_user.id)
    @attendee.where(study_group_id: study_group_id, user_id: current_user.id).destroy_all

    redirect_to :action => "show", :id => study_group_id
  end

  def unattend_from_dash
    course_id = params[:course_id]
    study_group_id = params[:study_group_id]
    study_group = StudyGroup.find(study_group_id)

    @attendee = Attendee.where(study_group_id: study_group_id, user_id: current_user.id)
    @attendee.where(study_group_id: study_group_id, user_id: current_user.id).destroy_all

    redirect_to :controller => "dashboard", :action => "index"
  end

  private
  def study_group_params
    params.require(:study_group).permit(:event_name, :date, :location, :description)
  end
end
