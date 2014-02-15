json.array!(@tweets) do |tweet|
  json.extract! tweet, :id, :tweet_id, :in_reply_to_status_id, :in_reply_to_user_id, :timestamp, :source, :text, :retweeted_status_id, :retweeted_status_user_id, :retweeted_status_timestamp, :expanded_urls
  json.url tweet_url(tweet, format: :json)
end
