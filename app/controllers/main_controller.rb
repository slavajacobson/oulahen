class MainController < ApplicationController
	layout 'admin'
	before_filter :authenticate_user!, except: [:contact_us_form]

	def admin
	end

	def contact_us_form
		
		if verify_recaptcha == false
			puts "Incorrect captcha"
			render json: '{"MusePHPFormResponse": { "success": false,"error": "' + recaptcha.errors.verification_failed + '"}}'
		elsif UserMailer.contact_form(params[:Name],params[:Email],params[:Phone],params[:Message], params[:recipient]).deliver
			render json: '{"FormResponse": { "success": true}}'
		else
			render json: '{"MusePHPFormResponse": { "success": false,"error": "Failed to send email"}}'
		end

	end
end
