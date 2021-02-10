require_relative "user_controller"

module User
  def create_user
    user_data = user_form

    @user = UserController.create(user_data)
  rescue Net::HTTPError => e
    puts e.response.parsed_response["errors"][0]
    puts
  end
end
