# frozen_string_literal: true

class ProjectCategory < Enumeration
  OptionName = :enumeration_project_categories

  def option_name
    OptionName
  end

  def objects_count
    Project.where(project_category_id: id).count
  end

  def transfer_relations(to)
    Project.where(project_category_id: id).update_all(project_category_id: to.id)
  end

  def self.default
    d = super
    d = first if d.nil?
    d
  end
end 