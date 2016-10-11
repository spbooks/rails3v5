class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :password_digest
      t.string :name
      t.string :email

      t.timestamps
    end

    add_column :stories, :user_id, :integer
    add_column :votes, :user_id, :integer
  end
end
