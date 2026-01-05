class ChangePostPostTexttoBody < ActiveRecord::Migration[8.1]
  def change
    rename_column :posts, :post_body, :body
  end
end
