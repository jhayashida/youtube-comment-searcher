class CommentsController < ApplicationController
  def index
    if (params.has_key?(:q))
      @comments = Comment.where("lower(text_display) LIKE ?", "%#{params[:q].gsub("'", "&#39;").downcase}%").order(comment_published_at: :desc).limit(10)
    else
      @comments = Comment.order(comment_published_at: :desc).limit(10)
    end
  end
end
