class AddDetailsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :title, :text
    add_column :tasks, :content, :text
  end
end
