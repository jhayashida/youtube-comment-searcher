class CommentsController < ApplicationController
  def index
    @comments = Comment.all

    if (params.has_key?(:q))
      @comments = @comments.where("lower(text_display) LIKE ?", "%#{params[:q].gsub("'", "&#39;").downcase}%")
    end

    if params.has_key?(:after) && params.has_key?(:before)
      @comments = @comments.where(comment_published_at: params[:after].to_date.beginning_of_day..params[:before].to_date.end_of_day)
    elsif !params.has_key?(:after) && params.has_key?(:before)
      @comments = @comments.where(comment_published_at: "01/01/1900".to_date..params[:before].to_date)
    elsif params.has_key?(:after) && !params.has_key?(:before)
      @comments = @comments.where(comment_published_at: params[:after].to_date..Date.today)
    else

    end

    @comments = @comments.order(comment_published_at: :desc).paginate(page: params[:page], per_page: 30)
  end
end
