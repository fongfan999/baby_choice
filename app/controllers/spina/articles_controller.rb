module Spina
  class ArticlesController < ApplicationController
    layout 'layouts/application'

    def index
      @articles = Spina::Article.newest_first.page(params[:page])

      respond_to do |format|
        format.html
        format.js
      end
    end

    def show
      @article ||= Spina::Article.live.find_by(slug: params[:id])

      if @article
        # Track visit
        @article.increment!

        @prev_article = @article.prev_article
        @next_article = @article.next_article
      else
        redirect_to root_path
        flash[:alert] = "Bài viết không tồn tại hoặc đã bị gỡ bỏ"
      end
    end
  end
end