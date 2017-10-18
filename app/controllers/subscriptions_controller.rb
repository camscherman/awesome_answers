class SubscriptionsController < ApplicationController

  def new
  end

  def create
    @name = params[:name]
  end
  # By setting an instance variable here, we are able to access its value in
  # the associated view file. Recall that each request renders only on action
  # which means other actions won't be able to access this instance variable

end
