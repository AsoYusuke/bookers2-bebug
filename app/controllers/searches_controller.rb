class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    #検索モデル = range
    @range = params[:range]
    #検索方法 = search 検索ワード = word
    if @range == "Users"
      @users = User.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end
end
