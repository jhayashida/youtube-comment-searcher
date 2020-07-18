class Comment < ApplicationRecord
    validates :yt_comment_id, uniqueness: true
end
