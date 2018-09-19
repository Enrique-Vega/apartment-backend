class ApplicationController < ActionController::API
  respond_to :json  # <- Add this line
  include ActionController::MimeResponds # <- Add this line
end
