class AddDescriptionToStories < ActiveRecord::Migration[5.0]
  def change
    add_column :stories, :description, :text
  end
end
