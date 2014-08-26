require 'thor'
require 'command_line_reporter'

require_relative 'io/format_helpers'
require_relative 'io/accounting_period_io_helper'
require_relative 'io/category_io_helper'
require_relative 'io/transaction_io_helper'
require_relative 'io/report_io_helper'
require_relative 'io/stdio'
require_relative 'interactions/interaction'
require_relative 'interactions/entity_interaction'
require_relative 'interactions/create_entity_interaction'
require_relative 'interactions/update_entity_interaction'
require_relative 'interactions/delete_entity_interaction'
require_relative 'interactions/accounting_periods/list_accounting_periods_interaction'
require_relative 'interactions/accounting_periods/show_current_accounting_period_interaction'
require_relative 'interactions/accounting_periods/set_current_accounting_period_interaction'
require_relative 'interactions/categories/list_categories_interaction'
require_relative 'interactions/transactions/list_transaction_interaction'
require_relative 'interactions/transactions/search_transaction_interaction'
require_relative 'interactions/reports/get_balance_report_interaction'
require_relative 'interactions/reports/get_category_report_interaction'
require_relative 'command'
require_relative 'commands/accounting_period_command'
require_relative 'commands/category_command'
require_relative 'commands/transaction_command'
require_relative 'commands/balance_command'
require_relative 'commands/report_command'
require_relative 'cli'