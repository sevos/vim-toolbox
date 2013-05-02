class AddDefaultValueToPluginsInstallationsCount < ActiveRecord::Migration
  def change
    Plugin.update_all "installations_count=0", "installations_count IS NULL"
    change_column :plugins, :installations_count, :integer, null: false, default: 0
  end
end
