module Spina
  module Admin
    class CategoriesController < AdminController
      before_filter :set_breadcrumb
      before_action :set_category, only: [:edit, :update, :destroy]

      layout "spina/admin/admin"

      def index
        @categories = Category.all
      end

      def new
        add_breadcrumb "New #{t('spina.categories.scaffold_name')}", spina.new_admin_category_path
        @category = Category.new
      end

      def create
        add_breadcrumb "New #{t('spina.categories.scaffold_name')}"
        @category = Category.new(category_params)
        if @category.save
          redirect_to spina.admin_categories_url
        else
          render :new
        end
      end

      def update
        add_breadcrumb @category.name
        if @category.update_attributes(category_params)
          redirect_to spina.admin_categories_url
        else
          render :edit
        end
      end

      def destroy
        @category.destroy
        redirect_to spina.admin_categories_url
      end

      private

      def set_category
        @category = Category.find(params[:id])
      end

      def set_breadcrumb
        add_breadcrumb t('spina.categories.scaffold_name_plural'), spina.admin_categories_path
      end

      def category_params
        params.require(:category).permit(:name)
      end
    end
  end
end