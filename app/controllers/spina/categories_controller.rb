module Spina
  class CategoriesController < ApplicationController
    layout 'layouts/application'
    helper :application

    def show
      @category ||= Spina::Category.find_by_slug(params[:id])

      if @category
        @articles = @category.articles.live.page(params[:page])

        respond_to do |format|
          format.html
          format.js
        end
      else
        redirect_to root_path
        flash[:alert] = "Danh mục bài viết không tồn tại"
      end
    end
  end
end