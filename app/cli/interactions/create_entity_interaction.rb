module FmCli
  class CreateEntityInteraction < FmCli::EntityInteraction

    def run(attributes, entity_identifier)

      entity_name = entity_name(entity_identifier)
      printable_entity_name = printable_entity_name(entity_identifier)

      begin

        form = form_class(entity_name).new(attributes)
        entity = use_case_class(entity_name).new(form).run
        io.print_success "Successfully created #{printable_entity_name}"
        io.print_blank_line
        io.send("print_#{entity_identifier.downcase}", entity)

      rescue ValidationError => e

        io.print_failure "#{printable_entity_name.capitalize} couldn't be created to following errors:"
        io.print_blank_line
        io.print_errors(e.errors)
      rescue StandardError => e
        io.print_failure e.message
      end
    end

    private

    def use_case_class(entity_name)
      "Create#{entity_name}".constantize
    end

    def form_class(entity_name)
      "#{entity_name}Form".constantize
    end
  end
end
