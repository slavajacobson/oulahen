module ApplicationHelper
	def link_to_add_fields(name, f, association)

	    new_object = f.object.send(association).klass.new
	    id = new_object.object_id
	    fields = f.fields_for(association, new_object, :child_index => id) do |builder|
	      render(association.to_s + "", :f => builder)
	    end
	    
	    link_to(name, '#', :class => "add_fields", :data => {:id => id, :fields => fields.gsub("\n", "")})
	end


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
		"#{page} - #{title}"
	end

	def title
		"Toronto Real Estate - Oulahen Team"
	end

	
end
