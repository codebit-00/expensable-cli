module Requester
  def select_main_menu_action
    prompt = "login | create_user | exit"
    options = %w[login create_user exit]
    gets_option(prompt, options)
  end

  def select_categories_menu_action
    prompt = "create | show ID | update ID | delete ID \nadd-to ID | toggle | next | prev | logout"
    options = %w[create show update delete add-to toggle next prev logout]
    gets_option(prompt, options)
  end

  def select_transaction_menu_action
    prompt = "add | update ID | delete ID \nnext | prev | back"
    options = %w[add update ID delete ID next prev logout back]
    gets_option_b(prompt, options)
  end

  def gets_option_b(prompt, options)
    puts prompt
    print "> "
    input = gets.chomp.split
    until options.include?(input[0])
      puts "Invalid option"
      print "> "
      input = gets.chomp.split
    end
    input
  end

  def login_form
    email = gets_string("email: ")
    password = gets_string("password: ")
    { email: email, password: password }
  end

  def gets_info_login(prompt, required: true)
    print prompt
    input = gets.chomp.strip

    if required
      while input.empty?
        puts "Cannot be blank"
        print prompt
        input = gets.chomp.strip
      end
    end
    input
  end

  def gets_option(prompt, options)
    puts prompt
    print "> "
    input = gets.chomp.split.map(&:strip)

    until options.include?(input[0])
      puts "Invalid option"
      print "> "
      input = gets.chomp.split.map(&:strip)
    end
    input
  end

  def user_form
    email = validate_email
    password = gets_string("password: ", length: 6)
    first_name = gets_string("First name: ", required: false)
    last_name = gets_string("Last name: ", required: false)
    phone = validate_phone
    puts "Welcome to Expensable #{first_name} #{last_name}"
    puts
    { email: email, password: password, first_name: first_name, last_name: last_name, phone: phone }
  end

  # Obtener datos que van a tabla de transactions
  def transaction_form
    amount = get_integer("Amount: ")
    date = get_valid_date("Date: ")
    notes = gets_string("Notes: ", required: false)
    { amount: amount, date: date, notes: notes }
  end

  def get_integer(prompt, required: true)
    print prompt
    input = gets.chomp.strip.to_i

    if required
      until input >= 1
        puts "Cannot be zero"
        print prompt
        input = gets.chomp.strip.to_i
      end
    end
    input
  end

  def get_valid_date(prompt, required: true)
    print prompt
    input = gets.chomp.strip

    if required
      while input.match?(/([12]\d{3}-(0[1-9]|1[0-2])-(0[1-9]|[12]\d|3[01]))/) == false
        puts "Required format: YYYY-MM-DD"
        print prompt
        input = gets.chomp.strip
      end
    end
    input
  end

  # Fin de obtener data de transaction

  def validate_email
    gets_user_data_email("email: ")
  end

  def gets_user_data_email(prompt, required: true)
    print prompt
    input = gets.chomp.strip

    if required
      while input.empty? || input.match(/\w*@\w*\.\w*/).nil?
        puts "Can't be blank" if input.empty?
        puts "Invalid format" unless input.match(/\w*@\w*\.\w*/)
        print prompt
        input = gets.chomp.strip
      end
    end
    input
  end

  def validate_phone
    gets_user_data_phone("phone: ")
  end

  def gets_user_data_phone(prompt)
    print prompt
    input = gets.chomp.strip

    unless input.empty?
      while input.match(/\+?5?1?\s?9\d{8}/).nil?
        puts "Required format: +51 111222333 or 111222333" unless input.match(/\+?5?1?\s?9\d{8}/)
        print prompt
        input = gets.chomp.strip
        break if input.empty?
      end
    end
    input.empty? ? "" : input
  end

  def gets_string(prompt, required: true, length: 0)
    print prompt
    input = gets.chomp.strip

    if required
      while input.empty? || input.size < length
        puts "Invalid format" if input.empty?
        puts "Minimun lenght of #{length}" if input.size < length
        print prompt
        input = gets.chomp.strip
      end
    end
    input
  end

  def category_form
    name = gets_string("Name: ")
    transaction = gets_string_type_transaction("Transaction: ")
    { name: name, transaction_type: transaction }
  end

  def gets_string_type_transaction(prompt)
    print prompt
    input = gets.chomp.strip
    until input.match?(/^expense$/) || input.match?(/^income$/)
      puts "Only income or expense"
      print prompt
      input = gets.chomp.strip
    end
    input
  end
end
