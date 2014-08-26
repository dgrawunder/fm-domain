module FmCli
  module Transaction
    def self.included(base)
      base.class_eval do

        def self.common_create_and_update_options
          method_option 'accounting-period', aliases: '-p'
          method_option 'category', aliases: '-c'
          method_option 'description', aliases: '-d'
          method_option 'amount', aliases: '-a'
          method_option 'type', aliases: '-t'
          method_option 'day-of-month', aliases: '-m'
        end

        desc 'add -d DESCRIPTION -a AMOUNT [OPTIONS]',
             "Adds a new transaction to the current or specified accounting period"
        common_create_and_update_options
        method_option 'template', aliases: '-T', type: :boolean, default: false

        def add
          attributes = {
              template: options[:templates]
          }
          fill_attributes_with_common_create_and_update_options(attributes, options)
          attributes[:template] = options[:template] if options[:template]
          attributes[:day_of_month] = options['day-of-month'] if options['day-of-month']

          run_interaction(:create_entity, attributes, :transaction)
        end

        desc 'update ID [OPTIONS]', 'Updates a transaction'
        common_create_and_update_options

        def update(id)
          attributes = {}
          fill_attributes_with_common_create_and_update_options(attributes, options)

          run_interaction(:update_entity, id, attributes, :transaction)
        end

        desc 'delete ID', 'Deletes a transaction forevermore'

        def delete(id)
          run_interaction(:delete_entity, id, :transaction)
        end

        # Creates a listing command for every transaction type e.g. expenses
        TransactionType::TYPES.each do |type_name, type_number|
          desc "#{type_name.to_s.pluralize} [OPTIONS]",
               "Lists all #{type_name.to_s.pluralize} to the current or specified accounting period."
          method_option 'accounting-period', aliases: '-p'
          method_option :templates, aliases: '-T', type: :boolean, default: false

          define_method type_name.to_s.pluralize do
            attributes = {
                type: type_number,
                template: options[:templates]
            }
            unless options[:templates]
              attributes[:accounting_period_name] = options['accounting-period'] if options['accounting-period']
            end
            run_interaction(:list_transaction, attributes)
          end
        end

        desc 'search SEARCH-TERM', 'Searches for current transactions'

        def search(search_term)
          attributes = {
              term: search_term
          }
          run_interaction(:search_transaction, attributes)
        end

        private

        def fill_attributes_with_common_create_and_update_options(attributes, options)
          attributes[:accounting_period_name] = options['accounting-period'] if options['accounting-period']
          attributes[:category_name] = options[:category] if options[:category]
          attributes[:description] = options[:description] if options[:description]
          attributes[:amount] = options[:amount] if options[:amount]
          attributes[:type] = options[:type] if options[:type]
        end
      end
    end
  end
end