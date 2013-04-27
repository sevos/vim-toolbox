class CreatePluginInstallations < ActiveRecord::Migration
  def change
    create_table :plugin_installations do |t|
      t.integer :user_id
      t.integer :plugin_id

      t.timestamps
    end
  end
end
