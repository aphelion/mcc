class ChangeColumnStatusInJobs < ActiveRecord::Migration[5.0]
  def change
    change_column_null :jobs, :status, false, 0
  end
end
