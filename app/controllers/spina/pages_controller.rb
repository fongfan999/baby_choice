module Spina
  class PagesController < Spina::ApplicationController
    include Spina::Frontend

    rescue_from ActiveRecord::RecordNotFound, with: :render_404

    before_action :current_user_can_view_page?, except: [:robots]

    helper_method :page

    def homepage
      render_with_template(page)
    end

    private

    def current_user_can_view_page?
      raise ActiveRecord::RecordNotFound if page.nil? || !page.live?

      current_user.present?
    end

    def render_404
      flash[:alert] = "Trang bạn đang tìm kiếm không tồn tại hoặc đã bị gỡ bỏ"
      redirect_to root_path
    end

  end
end