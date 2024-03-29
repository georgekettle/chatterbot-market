class AccountsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  skip_after_action :verify_authorized, only: [:show]

  # GET /account_settings
  def account_settings
    @account = current_account
    authorize @account
  end

  # GET /accounts/:id
  def show
    @account = Account.find(params[:id])
    @pagy, @chatbots = pagy(@account.chatbots.where(status: :marketplace))
  end

  def update
    @account = current_account
    authorize @account
    if @account.update(account_params)
      redirect_to account_settings_path, notice: "Account updated successfully"
    else
      render :edit
    end
  end

  private

  def account_params
    params.require(:account).permit(:name, :description, :url, :api_key_openai)
  end
end
