module Spina
  class ArticlesController < ApplicationController
    layout 'layouts/application'

    def index
      @articles = Spina::Article.order(created_at: :desc).all
    end

    def show
      @article ||= Spina::Article.find_by(slug: params[:id])
    end
  end
end