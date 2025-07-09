class Admin::WorklogsController < AdminController
  def index
    # Filters
    @users = User.all
    @projects = Project.all

    scope = Worklog.includes(:user, :project, :issue, :activity)
    scope = scope.where(user_id: params[:user_id]) if params[:user_id].present?
    scope = scope.where(project_id: params[:project_id]) if params[:project_id].present?
    scope = scope.where('date >= ?', params[:from_date]) if params[:from_date].present?
    scope = scope.where('date <= ?', params[:to_date]) if params[:to_date].present?

    # Calculate total hours for the filtered scope
    @total_hours = scope.sum(:hours)

    # Paginate the filtered scope
    @worklog_count = scope.count
    @worklog_pages = Paginator.new @worklog_count, per_page_option, params['page']
    @worklogs = scope.order(date: :desc, created_at: :desc)
                       .offset(@worklog_pages.offset)
                       .limit(@worklog_pages.per_page)
  end
end 