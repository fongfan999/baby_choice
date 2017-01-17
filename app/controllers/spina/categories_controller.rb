module Spina
  class CategoriesController < ApplicationController
    layout 'layouts/application'

    def show
      @category ||= Spina::Category.find_by_slug(params[:id])

      if @category
        @articles = @category.articles.live
      else
        redirect_to root_path
        flash[:alert] = "Danh mục bài viết không tồn tại"
      end
    end
  end
end