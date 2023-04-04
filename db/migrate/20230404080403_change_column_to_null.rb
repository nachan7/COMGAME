class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :posts, :member_id, true
    change_column_null :posts, :category_id, true
  end
end
