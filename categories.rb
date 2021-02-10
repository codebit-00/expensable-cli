require_relative "categories_controller"

module Categories
  def load_categories
    @categories = CategoriesController.index(@user[:token])
  rescue Net::HTTPError => e
    puts e.response.parsed_response["errors"][0]
    puts
  end

  def delete_category(id)
    # token = @user[:token]
    # @categories = CategoriesController.destroy(token, id)
    token = @user[:token]
    index = @categories.find_index { |category| category[:id] == id }
    delete_category = CategoriesController.destroy(token, id)
    if delete_category
      @categories[index] = delete_category
    else
      @categories.reject! { |categorie| categorie[:id] == id }
    end
  rescue Net::HTTPError => e
    puts e
    puts
  end

  def create_category
    category_data = category_form
    token = @user[:token]
    new_category = CategoriesController.create(category_data, token)
    @categories << new_category
  rescue Net::HTTPError => e
    puts e
    puts
  end

  def show_category(id)
    index = @categories.find_index { |categorie| categorie[:id] == id }
    token = @user[:token]
    @transactions = CategoriesController.show(token, id)
    transaction_page(index, id)
  rescue Net::HTTPError => e
    puts e
    puts
  end

  def update_category(id)
    index = @categories.find_index { |categorie| categorie[:id] == id }
    category_data = category_form

    token = @user[:token]
    update_category = CategoriesController.update(id, token, category_data)
    @categories[index] = update_category
  rescue Net::HTTPError => e
    puts e
    puts
  end

  def toggle_transaction_types
    @toggle = !@toggle
  end

  def next_month
    @current_month = @current_month.next_month
  end

  def prev_month
    @current_month = @current_month.prev_month
  end
end
