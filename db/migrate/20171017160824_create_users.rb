class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email, index: {unique: true}
      # we often search for users by email, so let's index it and enforce uniqueness
      t.string :password_digest

      t.timestamps
    end
  end
end
