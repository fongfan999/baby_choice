module Spina
  class ArticlesController < ApplicationController
    layout 'layouts/application'

    def index
      @articles = Spina::Article.live.newest_first
    end

    def show
      @article ||= Spina::Article.find_by(slug: params[:id])
      @prev_article = @article.prev_article
      @next_article = @article.next_article
    end
  end
end