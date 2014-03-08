# coding: utf-8
require 'csv'   # csv操作を可能にするライブラリ
require 'kconv' # 文字コード操作をおこなうライブラリ

class Tweet < ActiveRecord::Base
  
  belongs_to :user
  
  def self.import_csv(csv_file,user)
    # csvファイルを受け取って文字列にする
    csv_text = csv_file.read

    # 読み込む前に古いツイートをすべて削除する。
    user.tweet.delete_all

    #文字列をUTF-8に変換
    CSV.parse(Kconv.toutf8(csv_text)) do |row|

      # ヘッダー行を回避するためにtweet_idが数値でない場合は読み飛ばす
      if row[0] =~ /\A\d+\z/
        tweet = Tweet.new

        tweet.tweet_id              = row[0]
        tweet.in_reply_to_status_id = row[1]
        tweet.in_reply_to_user_id   = row[2]
        tweet.timestamp             = row[3]
        tweet.source                = row[4]
        tweet.text                  = row[5]
        tweet.retweeted_status_id   = row[6]
        tweet.retweeted_status_user_id    = row[7]
        tweet.retweeted_status_timestamp  = row[8]
        tweet.expanded_urls         = row[9]
        tweet.user_id = user.id
        
        tweet.save

      end

    end
    return true
  end

end
