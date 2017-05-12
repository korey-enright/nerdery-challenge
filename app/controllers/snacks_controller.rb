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
    # NerderySnackApiService.new.get_snack_list
    @suggestable_snacks = Snack.where("suggested = false AND optional = true")
    @snack = Snack.new
  end

  def create
    @snack = Snack.new(snack_params)
    if @snack.save
      flash[:success] = "Snack successfully added"
      redirect_to snacks_path
    else
      flash[:error] = "There was an error saving your snack"
      redirect_back(fallback_location: snacks_path)
    end
  end

  def vote
    snack = Snack.find(params[:id])
    if @current_votes > 3
      flash[:error] = "You have voted three times this month already"
    else
      flash[:success] = "You successfully voted for #{snack.name}"
      Vote.create(snack: snack, user: current_user)
    end
    redirect_to snacks_path
  end

  private

  def snack_params
    params.require(:snack).permit(:name, :purchase_locations, :optional,
                                  :suggested, :user_id)
  end
end
