class AddApprovedAtToPlugins < ActiveRecord::Migration
  def change
    add_column :plugins, :approved_at, :timestamp
  end
end
