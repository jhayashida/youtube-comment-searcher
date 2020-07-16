class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :author_channel_url
      t.text :author_display_name
      t.text :author_profile_image_url
      t.integer :like_count
      t.datetime :comment_published_at
      t.datetime :comment_updated_at
      t.text :text_display
      t.string :video_id

      t.timestamps
    end
  end
end
