class ApplicationController < ActionController::Base
  def fetch_data_for(data)
    HashWithIndifferentAccess.new(Rails.application.config.send(data))
  end
end
