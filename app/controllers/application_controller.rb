class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken

  # APIでは、CSRFチェックなし
  skip_before_action :verify_authenticity_token, if: :devise_controller?
end
