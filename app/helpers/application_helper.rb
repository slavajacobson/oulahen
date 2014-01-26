module ApplicationHelper

	def gem_exists? gem_name
		rc = true

		begin
			require gem_name
		rescue Exception
			rc = false
		end

		rc
	end

	def flash_class(level)
    case level
	    when :notice then "alert alert-info"
	    when :success then "alert alert-success"
	    when :error then "alert alert-error"
	    when :alert then "alert alert-error"
    end
	end

	def default_title page
		"#{page} - Toronto Real Estate - Oulahen Team"
	end

	
end
