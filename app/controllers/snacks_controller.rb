class SnacksController < ApplicationController

  def index
    NerderySnackApiService.new.get_snack_list
    @non_optional_snacks = Snack.where(optional: true)
    @suggested_snacks = Snack.where(suggested: true)
  end

  def show
  end

  def new
    NerderySnackApiService.new.get_snack_list
    @suggestable_snacks = Snack.where("suggested = false AND optional = false")
    @snack = Snack.new
  end

  def create
  end
end
