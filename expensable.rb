# Start here. Happy coding!
require "terminal-table"
require_relative "presenter"
require_relative "requester"
require_relative "categories"
require_relative "transaction"
require_relative "session"
require_relative "user"
require "date"

class Expensable
  include Presenter
  include Requester
  include Session
  include Categories
  include Transaction
  include User
  include Categories

  def initialize
    @user = nil
    @transactions = []
    @current_month = Date.today
    @categories = []
    @toggle = true
  end

  def start
    print_welcome
    action, _id = select_main_menu_action
    until action == "exit"
      case action
      when "login" then login
      when "create_user" then create_user
      end
      categories_page if @user
      print_welcome
      action, _id = select_main_menu_action
    end
    goodbye
  end

  def categories_page
    load_categories
    print_categories
    action, id = select_categories_menu_action
    until action == "logout"
      case action
      when "create" then create_category
      when "show" then show_category(id.to_i)
      when "update" then update_category(id.to_i)
      when "delete" then delete_category(id.to_i)
      when "add-to" then add_transaction(id.to_i)
      when "toggle" then toggle_transaction_types
      when "next" then next_month
      when "prev" then prev_month
      end
      print_categories
      action, id = select_categories_menu_action
    end
  end

  def transaction_page(index, id)
    load_transactions(id.to_i)
    print_transaction(index)
    category_id = id
    action, id = select_transaction_menu_action
    until action == "back"
      case action
      when "add" then add_transaction(category_id)
      when "update"
        update_transaction(id.to_i, category_id)
      when "delete" then delete_transaction(id.to_i, category_id)
      when "next" then next_month
      when "prev" then prev_month
      end
      print_transaction(index)
      action, id = select_transaction_menu_action
    end
    categories_page
  end
end

app = Expensable.new
app.start
