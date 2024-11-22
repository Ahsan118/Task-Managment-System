class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  
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
end
