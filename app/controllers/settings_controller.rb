class SettingsController < ApplicationController
  before_action(:create_settings, only: %w(edit))

  def edit
    @setting = Setting.first
  end

  def update
    @setting = Setting.first

    if @setting.update(setting_params)
      flash[:success] = t('.success')
      redirect_to edit_settings_path
    else
      render :edit
    end
  end

  private

  def setting_params
    params.require(:setting).permit(
      :aws_key, :aws_secret, :slack_url, :secondary_slack_url
    )
  end

  def create_settings
    SettingsCreator.execute
  end
end
