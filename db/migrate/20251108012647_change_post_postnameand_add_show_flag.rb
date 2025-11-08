class ChangePostPostnameandAddShowFlag < ActiveRecord::Migration[8.1]
  def change
    rename_column :posts, :post, :post_body
    add_column :posts, :show, :boolean, default: true
  end
end
