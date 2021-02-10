require "httparty"
require "json"

class TransactionController
  include HTTParty
  base_uri "https://expensable-api.herokuapp.com/"

  def self.index(token, id)
    options = {
      headers: { "Authorization": "Token token=#{token}" }
    }

    response = get("/categories/#{id}/transactions", options)

    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.add(token, id, new_transaction_data)
    options = {
      headers: { "Authorization": "Token token=#{token}", "Content-Type" => "application/json" },
      body: new_transaction_data.to_json
    }

    response = post("/categories/#{id}/transactions", options)

    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.update(token, transaction_data, id, category_id)
    options = {
      headers: { "Content-Type" => "application/json", "Authorization" => "Token token=#{token}" },
      body: transaction_data.to_json
    }
    response = patch("/categories/#{category_id}/transactions/#{id}", options)
    raise Net::HTTPError.new(response.message, response) unless response.success?

    JSON.parse(response.body, symbolize_names: true)
  end

  def self.destroy(token, id, category_id)
    options = {
      headers: { "Authorization" => "Token token=#{token}" }
    }
    response = delete("/categories/#{category_id}/transactions/#{id}", options)
    raise Net::HTTPError.new(response.message, response) unless response.code == 204
  end
end
