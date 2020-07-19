class CommentsController < ApplicationController
  def index
    @comments = Comment.all

    if (params.has_key?(:q))
      @comments = @comments.where("lower(text_display) LIKE ?", "%#{params[:q].gsub("'", "&#39;").downcase}%")
    end
    
    if (params.has_key?(:exclude_of_course) && params[:exclude_of_course] == "on")
      @comments = @comments.where("lower(text_display) ~* ?", '(?<![oO][fF]\s)(course)')
    end

    if !params.has_key?(:after) || params[:after] == ""
      params[:after] = "01/01/1900".to_date
    end

    if !params.has_key?(:before) || params[:before] == ""
      params[:before] = Date.today
    end

    @comments = @comments.where(comment_published_at: params[:after].to_datetime.beginning_of_day..params[:before].to_datetime.end_of_day)


    if !params.has_key?(:results_per_page) || params[:results_per_page] == ""
      params[:results_per_page] = 50
    end
    
    if (params.has_key?(:sort_by) && params[:sort_by] == "Date: New - Old")
      @comments = @comments.order(comment_published_at: :desc)
    else
      @comments = @comments.order(comment_published_at: :asc)
    end
    
    @comments = @comments.paginate(page: params[:page], per_page: params[:results_per_page])
  end
end
