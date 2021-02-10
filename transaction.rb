require_relative "transaction_controller"

module Transaction
  def load_transactions(id)
    @transactions = TransactionController.index(@user[:token], id)
  end

  def add_transaction(id)
    new_transaction_data = transaction_form
    token = @user[:token]

    @transactions << TransactionController.add(token, id, new_transaction_data)
  rescue Net::HTTPError => e
    puts e
    puts
  end

  def update_transaction(id, category_id)
    update_tran = transaction_form
    token = @user[:token]
    new_update_tran = TransactionController.update(token, update_tran, id, category_id)
    @transactions << new_update_tran
  end

  def delete_transaction(id, category_id)
    token = @user[:token]
    TransactionController.destroy(token, id, category_id)
  rescue Net::HTTPError => e
    puts e.message
    puts
  end
  # def toggle_category; end

  # def next_month
  #   @current_month = @current_month.next_month
  # end

  # def prev_month
  #   @current_month = @current_month.prev_month
  # end
end
