class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tweet_id
      t.string :in_reply_to_status_id
      t.string :in_reply_to_user_id
      t.datetime :timestamp
      t.text :source
      t.text :text
      t.string :retweeted_status_id
      t.string :retweeted_status_user_id
      t.datetime :retweeted_status_timestamp
      t.string :expanded_urls

      t.timestamps
    end
  end
end
