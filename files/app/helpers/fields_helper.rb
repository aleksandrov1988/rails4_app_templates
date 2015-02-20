module FieldsHelper
  def link_to_remove_fields(f, options={})
    name=options[:title] || "Удалить"
    css_classes=['remove_fields']
    if options[:class]
      if options[:class].is_a?(Array)
        css_classes+=options[:class]
      else
        css_classes << options[:class]
      end
    else
      css_classes << 'dashed'
    end
    f.hidden_field(:_destroy, class: 'remove_fields') + link_to(?#, class: css_classes) { fa_icon('times', title: name) }
  end


  def link_to_add_fields(name, f, association, attrs={})
    new_object = f.object.class.reflect_on_association(association).klass.new(attrs)
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(?#, class: "add_fields dashed", data: {content: "#{fields}", association: association}) { fa_icon("plus")+" #{name}" }
  end

end