class AddColumnStatusToJobs < ActiveRecord::Migration[5.0]
  def change
    add_column :jobs, :status, :integer
  end
end
