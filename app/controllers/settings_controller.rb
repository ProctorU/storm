class SettingsController < ApplicationController
  before_action(:authenticate_user!)
  before_action(:create_settings, only: %w(edit))

  def edit
    @setting = Setting.first
  end

  def update
    @setting = Setting.first

    if @setting.update(setting_params)
      flash[:notice] = 'Your settings have been updated.'
      redirect_to root_path
    else
      flash[:alert] = 'Something went wrong updating settings.
        Please check and try again'
      render :edit
    end
  end

  private

  def setting_params
    params.require(:setting).permit(:aws_key, :aws_secret, :slack_url)
  end

  def create_settings
    SettingsCreator.execute if Setting.count.zero?
  end
end
