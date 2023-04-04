class RenameMemberIdColumnToPosts < ActiveRecord::Migration[6.1]
  def change
    rename_column :posts, :member_id, :member_id
  end
end
