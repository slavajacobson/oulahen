class MainController < ApplicationController
	layout 'admin'
	before_filter :authenticate_user!, except: [:contact_us_form]

	def admin
	end

	def contact_us_form
		#debugger

		if UserMailer.contact_form(params[:Name],params[:Email],params[:Phone],params[:Message]).deliver

			render json: '{"FormResponse": { "success": true}}'
		else
			render json: '{"MusePHPFormResponse": { "success": false,"error": "Failed to send email"}}'
		end

	end
end
