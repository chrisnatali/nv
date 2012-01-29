class AdminAreaController < ApplicationController

  #force users to login here
  before_filter :authorize

  layout "admin"

end
