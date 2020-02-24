class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session, if: Proc.new {|c| c.request.format.json? }
  before_action :authenticate_user!,  except: [:home]
end
