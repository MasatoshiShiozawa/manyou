class AddDetailsToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :deadline, :datetime
    add_column :tasks, :status, :string
    add_column :tasks, :priority, :integer
  end
end
