class CreatePlugins < ActiveRecord::Migration
  def change
    create_table :plugins do |t|
      t.string :repository

      t.timestamps
    end
  end
end
