class RenameJobsToBuilds < ActiveRecord::Migration[5.0]
  def change
    rename_table :jobs, :builds
  end
end
