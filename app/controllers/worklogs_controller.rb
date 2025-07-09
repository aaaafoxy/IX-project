class WorklogsController < ApplicationController
  before_action :require_login
  before_action :forbid_admin

  def new
    @worklog = Worklog.new(date: Date.today, user: User.current)
  end

  def create
    @worklog = Worklog.new(worklog_params)
    @worklog.user = User.current
    @worklog.author_id = User.current.id
    if @worklog.save
      flash[:notice] = '工时填报成功！'
      redirect_to new_worklog_path
    else
      render :new
    end
  end

  def issues_by_project
    project = Project.find_by(id: params[:project_id])
    issues = project ? project.issues.select(:id, :subject) : []
    render json: issues
  end

  def history
    @projects = Project.all
    @q_project_id = params[:project_id]
    @q_date_from = params[:date_from]
    @q_date_to = params[:date_to]
    @worklogs = Worklog.where(user_id: User.current.id)
    if @q_project_id.present?
      @worklogs = @worklogs.where(project_id: @q_project_id)
    end
    if @q_date_from.present?
      @worklogs = @worklogs.where('date >= ?', @q_date_from)
    end
    if @q_date_to.present?
      @worklogs = @worklogs.where('date <= ?', @q_date_to)
    end
    @worklogs = @worklogs.includes(:project, :issue).order(date: :desc)
  end

  private
  def worklog_params
    params.require(:worklog).permit(:date, :project_id, :issue_id, :hours, :remark, :activity_id)
  end

  def forbid_admin
    if User.current.admin?
      render_403
    end
  end
end 