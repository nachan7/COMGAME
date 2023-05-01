class AddScoreToPosts < ActiveRecord::Migration[6.1]
  def create
    add_column :posts, :score, :decimal, precision: 5, scale: 3
  end
end
