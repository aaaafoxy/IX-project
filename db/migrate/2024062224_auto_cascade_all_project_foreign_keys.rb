class AutoCascadeAllProjectForeignKeys < ActiveRecord::Migration[6.1]
  def up
    connection = ActiveRecord::Base.connection
    connection.tables.each do |table|
      next if table == 'schema_migrations' || table == 'ar_internal_metadata'
      
      # 获取表的外键约束
      foreign_keys = connection.foreign_keys(table)
      foreign_keys.each do |fk|
        if fk.to_table == 'projects'
          begin
            # 安全地移除外键约束
            if foreign_key_exists?(table, :projects, column: fk.options[:column])
              remove_foreign_key table, column: fk.options[:column]
            end
            # 重新添加外键约束，设置级联删除
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
    puts "警告: 无法自动恢复原有的外键约束行为，请手动处理"
  end
end 