require "httparty"
require "json"

class CategoriesController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com/"

  def self.index(token)
    options = {
      headers: { "Authorization": "Token token=#{token}" }
    }

    response = get("/categories", options)

    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.destroy(token, id)
    options = {
      headers: { "Authorization": "Token token=#{token}" }
    }
    response = delete("/categories/#{id}", options)

    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true) if response.body
  end

  def self.show(token, id)
    options = {
      headers: { "Authorization": "Token token=#{token}" }
    }
    response = get("/categories/#{id}", options)

    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.update(id, token, category_data)
    options = {
      headers: { "Content-Type": "application/json", "Authorization": "Token token=#{token}" },
      body: category_data.to_json
    }
    response = patch("/categories/#{id}", options)

    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.create(category_data, token)
    options = {
      headers: { "Content-Type": "application/json", "Authorization": "Token token=#{token}" },
      body: category_data.to_json
    }

    response = post("/categories", options)

    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true) if response.body
  end
end
