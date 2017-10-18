class AddViewCountToQuestion < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :view_count, :integer
    # first arg is the table name (not the model name)
    # second arg is the column name
    # third arg is the column type
  end
end
