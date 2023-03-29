class AccountsController < ApplicationController
  # GET /account_settings
  def account_settings
    @account = current_account
    authorize @account
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
    params.require(:account).permit(:name, :api_key_openai)
  end
end
