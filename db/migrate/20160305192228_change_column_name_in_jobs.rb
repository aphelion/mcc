class ChangeColumnNameInJobs < ActiveRecord::Migration[5.0]
  def change
    change_column :jobs, :name, :string
  end
end
