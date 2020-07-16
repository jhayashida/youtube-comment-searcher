class AddYtCommentIdToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :yt_comment_id, :string
  end
end
