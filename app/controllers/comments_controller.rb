class CommentsController < ApplicationController
  def index
    if (params.has_key?(:q))
      @comments = Comment.where("text_display LIKE ?", "%#{params[:q]}%").order(comment_published_at: :desc).limit(10)
    else
      @comments = Comment.order(comment_published_at: :desc).limit(10)
    end
  end
end
