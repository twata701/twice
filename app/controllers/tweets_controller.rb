# coding: utf-8

class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
  before_action :check_user
  before_action :set_user
  before_action :make_archive

  # GET /tweets
  # GET /tweets.json
  def index
    @tweets = @user.tweet.order(:id).page params[:page]
  end

  # GET /tweets/1
  # GET /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets
  # POST /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
        format.json { render action: 'show', status: :created, location: @tweet }
      else
        format.html { render action: 'new' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1
  # PATCH/PUT /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1
  # DELETE /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url }
      format.json { head :no_content }
    end
  end
  
  # GET /tweets/import_csv_new
  def import_csv_new
  end  

  # POST /tweets/import_csv
  def import_csv
    respond_to do |format|
      if Tweet.import_csv(params[:csv_file],current_user)
        format.html { redirect_to tweets_path }
        format.json { head :no_content }
      else
        format.html { redirect_to tweets_path, :notice => "CSVファイルの読み込みに失敗しました。" }
        format.json { head :no_content }
      end
    end
  end  
  
  # GET /tweets/archives/201402
  def archives
    @tweets = @user.tweet
             .where("strftime('%Y%m', tweets.timestamp) = '"+params[:yyyymm]+"'")
             .order(:id)
             .page params[:page]
  end  
  
  # GET /tweets/search/keyword
  def search
    @tweets = @user.tweet
             .search(:text_cont => params[:q]).result
             .order(:id)
             .page params[:page]
  end  
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:tweet_id, :in_reply_to_status_id, :in_reply_to_user_id, :timestamp, :source, :text, :retweeted_status_id, :retweeted_status_user_id, :retweeted_status_timestamp, :expanded_urls)
    end
    
    # ユーザがログインしていなければ、ホームにリダイレクト
    def check_user
      unless user_signed_in?
        redirect_to :root
      end
    end
    
    # アーカイブ見出し作成
    def make_archive
      @archives = @user.tweet.group("strftime('%Y%m', tweets.timestamp)")
                             .order("strftime('%Y%m', tweets.timestamp) desc")
                             .count
    end
    
    # インスタンス変数にログイン中のユーザをセット
    def set_user
      @user = current_user
    end

end
