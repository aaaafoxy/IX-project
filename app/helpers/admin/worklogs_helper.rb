module Admin::WorklogsHelper
  def users_for_select(users, selected_user_id)
    # Sort users by name for a user-friendly dropdown
    options_from_collection_for_select(users.sort_by(&:name), :id, :name, selected_user_id)
  end

  def projects_for_select(projects, selected_project_id)
    # Sort projects by name for a user-friendly dropdown
    options_from_collection_for_select(projects.sort_by(&:name), :id, :name, selected_project_id)
  end
end 