class AddDescriptionToPlugins < ActiveRecord::Migration
  def change
    add_column :plugins, :description, :text
  end
end
