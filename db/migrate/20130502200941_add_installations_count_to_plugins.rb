class AddInstallationsCountToPlugins < ActiveRecord::Migration
  def change
    add_column :plugins, :installations_count, :integer
  end
end
