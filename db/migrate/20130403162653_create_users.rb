class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :user_name
      u.string :email
      u.string :password
      u.string :secret_key
      u.timestamps
    end
  end
end
