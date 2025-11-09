class ChangePasswordDigesttoPassword < ActiveRecord::Migration[8.1]
  def change
    rename_column :users, :password_digest, :password
  end
end
