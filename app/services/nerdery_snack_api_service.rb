class NerderySnackApiService
  def initialize
    @key = ENV["nerdery_api_key"]
    @url = "https://api-snacks.nerderylabs.com/v1/snacks"
  end

  def get_snack_list
    begin
      response = RestClient.get(@url, { Authorization: "ApiKey " + @key })
    rescue RestClient::ExceptionWithResponse => error
      error.response.to_s
    end
    data = JSON.parse(response.body)
    data.each do |snack|
      fixed_snack = snack.transform_keys do |key|
        key.to_s.underscore
      end
      new_snack = Snack.find_or_create_by(name: fixed_snack["name"])
      new_snack.update_attributes(fixed_snack)
    end
  end

  def add_suggestion(snack)
    payload = { name: snack.name, location: snack.purchase_locations }
    payload = JSON.generate(payload)
    begin
      response = RestClient.post(@url, payload, { content_type: :json, Authorization: "ApiKey " + @key })
    rescue RestClient::ExceptionWithResponse => error
      error.response.to_s
    end
  end

  private

  def camelize(data)
    data.transform_keys { |key| key.to_s.camelize }
  end

end
