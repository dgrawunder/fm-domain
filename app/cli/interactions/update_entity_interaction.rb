module FmCli
  class UpdateEntityInteraction < EntityInteraction

    def run(id, attributes, entity_identifier)

      entity_name = entity_name(entity_identifier)
      printable_entity_name = printable_entity_name(entity_identifier)

      begin

        form = fill_form_use_case_class(entity_name).new(id).run
        attributes.each do |attribute, value|
          form.public_send("#{attribute}=", value)
        end
        entity = update_entity_use_case_class(entity_name).new(id, form).run

        io.print_success "Successfully updated #{printable_entity_name}"
        io.print_blank_line
        io.send("print_#{entity_identifier}", entity)
      rescue ValidationError => e
        io.print_failure "#{entity_name} couldn't be updated to following errors:"
        io.print_blank_line
        io.print_errors(e.errors)
      rescue RecordNotFoundError
        io.print_failure "Couldn't find #{printable_entity_name} with id='#{id}'"
      end

    end

    private

    def fill_form_use_case_class(entity_name)
      "Fill#{entity_name}Form".constantize
    end

    def update_entity_use_case_class(entity_name)
      "Update#{entity_name}".constantize
    end
  end

end
