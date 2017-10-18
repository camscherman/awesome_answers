class AddIsAdminToUsers < ActiveRecord::Migration[5.1]
  def change
    #  You can set default on columns at database level by specifying 
    add_column :users, :is_admin, :boolean, default: false
  end
  # Any table column wher its type is a boolean, the model instance method 
  # access will be available with and without a question mark
  # User.first.is_admin? OR User.first.is_admin both work!!
end
