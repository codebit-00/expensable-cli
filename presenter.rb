require "terminal-table"
require "date"

module Presenter
  def print_welcome
    puts "####################################"
    puts "#       Welcome to Expensable      #"
    puts "####################################"
  end

  def print_categories
    table = @toggle ? print_expense : print_income
    puts table
  end

  # def display_toggle_view; end

  def print_expense
    table = Terminal::Table.new
    table.title = "Expenses\n#{@current_month.strftime('%B')} #{@current_month.strftime('%Y')}"
    table.headings = %w[ID Category Total]
    table.rows = array_transaction_expense.map do |category|
      [
        category[:id],
        category[:name],
        total_category_amount(category)
      ]
    end
    table
  end

  def print_income
    table = Terminal::Table.new
    table.title = "Income\n#{@current_month.strftime('%B')} #{@current_month.strftime('%Y')}"
    table.headings = %w[ID Category Total]
    table.rows = array_transaction_income.map do |category|
      [
        category[:id],
        category[:name],
        total_category_amount(category)
      ]
    end
    table
  end

  def total_category_amount(category)
    total_amount = 0
    category[:transactions].each do |transaction|
      current_transaction = transaction[:date].split("-")
      current_transaction.pop
      total_amount += transaction[:amount] if current_transaction.join(",") == @current_month.strftime("%Y,%m")
    end
    total_amount
  end

  def array_transaction_expense
    array_of_transactions = []
    @categories.map { |category| array_of_transactions << category if category[:transaction_type] == "expense" }
    array_of_transactions
  end

  def array_transaction_income
    array_of_transactions = []
    @categories.map { |category| array_of_transactions << category if category[:transaction_type] == "income" }
    array_of_transactions
  end

  def print_transaction(index)
    table = Terminal::Table.new
    table.title = "#{@categories[index][:name]} \n#{@current_month.strftime('%B')} #{@current_month.strftime('%Y')}"
    table.headings = %w[ID Date Amount Notes]
    row = []
    @transactions.each do |transaction|
      current_transaction = transaction[:date].split("-")
      current_transaction.pop
      next unless current_transaction.join(",") == @current_month.strftime("%Y,%m")

      row << [
        transaction[:id],
        transaction[:date],
        transaction[:amount],
        transaction[:notes]
      ]
    end
    table.rows = row
    puts @current_month
    puts table
  end
  # goodbye

  def goodbye
    puts "####################################"
    puts "#    Thanks for using Expensable   #"
    puts "####################################"
  end
end
