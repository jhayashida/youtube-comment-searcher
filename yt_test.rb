require 'rubygems'
require 'google/apis/youtube_v3'

yt_service = Google::Apis::YoutubeV3::YouTubeService.new

yt_service.key = Rails.application.credentials[:development][:apis][:youtube][:youtube_api_key]

response = yt_service.list_comment_threads('snippet', all_threads_related_to_channel_id: Rails.application.credentials[:development][:apis][:youtube][:youtube_all_threads_related_to_channel_id]

response.items.each do |i|
    snip = i.snippet.top_level_comment.snippet
    Comment.create!(yt_comment_id: i.snippet.top_level_comment.id, author_channel_url: snip.author_channel_url, author_display_name: snip.author_display_name, author_profile_image_url: snip.author_profile_image_url, like_count: snip.like_count, comment_published_at: DateTime.parse(snip.published_at), comment_updated_at: DateTime.parse(snip.updated_at), text_display: snip.text_display, video_id: snip.video_id)
end

next_page_token = response.next_page_token

while !next_page_token.nil? && next_page_token != ""
    response = yt_service.list_comment_threads('snippet', all_threads_related_to_channel_id: Rails.application.credentials[:development][:apis][:youtube][:youtube_all_threads_related_to_channel_id], page_token: next_page_token)

    response.items.each do |i|
        snip = i.snippet.top_level_comment.snippet
        Comment.create(yt_comment_id: i.snippet.top_level_comment.id, author_channel_url: snip.author_channel_url, author_display_name: snip.author_display_name, author_profile_image_url: snip.author_profile_image_url, like_count: snip.like_count, comment_published_at: DateTime.parse(snip.published_at), comment_updated_at: DateTime.parse(snip.updated_at), text_display: snip.text_display, video_id: snip.video_id)
    end

    next_page_token = response.next_page_token
    puts next_page_token + "\n\n"
end
