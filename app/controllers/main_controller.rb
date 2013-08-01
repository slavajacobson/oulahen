class MainController < ApplicationController
	layout 'admin'
	before_filter :authenticate_user!

	def admin
	end
end
