class SnacksController < ApplicationController
  before_action :authenticate_user!

  def index
    NerderySnackApiService.new.get_snack_list
    @non_optional_snacks = Snack.where(optional: false)
    @suggested_snacks = Snack.where(suggested: true, optional: true)
  end

  def show
  end

  def new
    NerderySnackApiService.new.get_snack_list
    @suggestable_snacks = Snack.where("suggested = false AND optional = true")
    @suggested_snack = Snack.new
    @snack = Snack.new
  end

  def create
    @snack = Snack.new(snack_params)
    if current_user.snacks.where("suggested_at > ?", Date.today.beginning_of_month).any?
      flash[:error] = "You have already suggested a snack this month"
      redirect_to snacks_path
    else
      if @snack.save
        NerderySnackApiService.new.add_suggestion(@snack)
        flash[:success] = "Snack successfully added"
        redirect_to snacks_path
      else
        flash[:error] = "There was an error saving your snack"
        redirect_back(fallback_location: snacks_path)
      end
    end
  end

  def vote
    snack = Snack.find(params[:id])
    if @current_votes >= 3
      flash[:error] = "You have voted three times this month already"
    else
      flash[:success] = "You successfully voted for #{snack.name}"
      Vote.create(snack: snack, user: current_user)
    end
    redirect_to snacks_path
  end

  def suggest
    snack = Snack.find_by(name: snack_params[:name])
    if current_user.snacks.where("suggested_at > ?", Date.today.beginning_of_month).any?
      flash[:error] = "You have already suggested a snack this month"
    else
      if snack.update(snack_params)
        flash[:success] = "You suggested #{snack.name}"
      else
        flash[:error] = "Something went wrong"
      end
    end
    redirect_to snacks_path
  end

  private

  def snack_params
    params.require(:snack).permit(:name, :purchase_locations, :optional,
                                  :suggested, :user_id, :suggested_at)
  end
end
