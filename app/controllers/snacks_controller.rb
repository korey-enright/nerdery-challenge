class SnacksController < ApplicationController
  before_action :authenticate_user!

  def index
    # NerderySnackApiService.new.get_snack_list
    @non_optional_snacks = Snack.where(optional: false)
    @suggested_snacks = Snack.where(suggested: true, optional: true)
  end

  def show
  end

  def new
    NerderySnackApiService.new.get_snack_list
    @suggestable_snacks = Snack.where("suggested = false AND optional = true")
    @snack = Snack.new
  end

  def create
  end
end
