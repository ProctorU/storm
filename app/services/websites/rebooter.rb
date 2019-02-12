# frozen_string_literal: true

module Websites
  # Rebooter
  class Rebooter
    attr_reader(:website)

    def initialize(website)
      @website = website
    end

    def reboot
      website.update_attributes(rebooting: true)
      client.instance(website.aws_instance_id).reboot
      status = build_status("#{I18n.t('base.rebooting')}: #{website.name}.")
    rescue => e
      status = build_status(
        "#{I18n.t('base.failed_to_reboot')} #{website.name}: #{e}."
      )
    ensure
      status
    end

    private

    def client
      Aws.config.update(
        region: website.aws_region,
        credentials: aws_credentials
      )

      Aws::EC2::Resource.new
    end

    def aws_credentials
      Aws::Credentials.new(
        Setting.first.aws_key,
        Setting.first.aws_secret
      )
    end

    def build_status(message)
      OpenStruct.new(website: website, message: message)
    end
  end
end
