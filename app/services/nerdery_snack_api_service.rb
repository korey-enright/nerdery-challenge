class NerderySnackApiService
  def initialize
    @key = ENV["nerdery_api_key"]
    @snacks = Snack.all
    @url = "https://api-snacks.nerderylabs.com/v1/snacks"
  end

  def get_snack_list
    response = RestClient.get(@url, {Authorization: "ApiKey " + @key})
    pry
  end

  def add_suggestion

  end
end
