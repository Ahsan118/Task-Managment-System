class ApplicationController < ActionController::Base
  include Pundit::Authorization
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private
  
  def handle_error(resource)
    flash.now[:error] = resource.errors.full_messages.first
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update('flash-messages', inline: "<%= flash_messages %>")
        ]
      end
    end
  end

  def user_not_authorized
    flash[:error] = 'You are not authorized to perform this action.'
    redirect_to authenticated_user_root_path
  end
end
