module ApplicationHelper
	def link_to_remove_fields(name, f)
		f.hidden_field(:_destroy)+link_to(name,'#', :class => "remove_field")
	end

	def link_to_add_fields(name, f, association)
	new_object = f.object.class.reflect_on_association(association).klass.new
	fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
	  render(association.to_s.singularize + "_fields", :f => builder)
	end
	content_tag(:a, name, "href"=>"#", "data-association"=> '#{association}', "data-fields"=>'#{escape_javascript(fields)}', :class => "add_field")
	end
end
