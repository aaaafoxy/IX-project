class CascadeAllProjectForeignKeys < ActiveRecord::Migration[6.1]
  def up
    tables = [
      :attachments, :versions, :boards, :repositories, :wikis, :issue_categories,
      :enabled_modules, :custom_values, :queries, :changesets
    ]
    tables.each do |table|
      if table_exists?(table) && foreign_key_exists?(table, :projects)
        remove_foreign_key table, :projects
        add_foreign_key table, :projects, on_delete: :cascade
      end
    end
  end

  def down
    tables = [
      :attachments, :versions, :boards, :repositories, :wikis, :issue_categories,
      :enabled_modules, :custom_values, :queries, :changesets
    ]
    tables.each do |table|
      if table_exists?(table) && foreign_key_exists?(table, :projects)
        remove_foreign_key table, :projects
        add_foreign_key table, :projects
      end
    end
  end
end 