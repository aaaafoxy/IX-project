class AutoCascadeAllProjectForeignKeys < ActiveRecord::Migration[6.1]
  def up
    connection = ActiveRecord::Base.connection
    connection.tables.each do |table|
      next if table == 'schema_migrations' || table == 'ar_internal_metadata'
      foreign_keys = connection.foreign_keys(table)
      foreign_keys.each do |fk|
        if fk.to_table == 'projects'
          begin
            remove_foreign_key table, name: fk.options[:name]
            add_foreign_key table, :projects, column: fk.options[:column], on_delete: :cascade
          rescue => e
            puts "[Skip] #{table} 外键处理失败: #{e.message}"
          end
        end
      end
    end
  end

  def down
    # 无法自动恢复原有 on_delete 行为，如需恢复请手动处理
  end
end 