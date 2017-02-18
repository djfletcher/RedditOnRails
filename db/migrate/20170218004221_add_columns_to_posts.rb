class AddColumnsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :title, :string
    add_column :posts, :url, :string
    add_column :posts, :content, :string
    add_column :posts, :sub_id, :integer
    add_column :posts, :author_id, :integer
  end
end
