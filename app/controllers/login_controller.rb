class LoginController < ApplicationController
	before_filter :login_check

private
  def login_check
  	unless current_user
  		redirect_to root_url
  	end
  end
end