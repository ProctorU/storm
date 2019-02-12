# frozen_string_literal: true

module WebsitesHelper
  def options_for_aws_region(selected = nil)
    options_for_select(aws_regions, selected)
  end

  def aws_regions
    # http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/
    # using-regions-availability-zones.html#concepts-available-regions
    [
      ['US East (N. Virginia) · us-east-1', 'us-east-1'],
      ['US East (Ohio) · us-east-2', 'us-east-2'],
      ['US West (N. California) · us-west-1', 'us-west-1'],
      ['US West (Oregon) · us-west-2', 'us-west-2'],
      ['Canada (Central) · ca-central-1', 'ca-central-1'],
      ['EU (Ireland) · eu-west-1', 'eu-west-1'],
      ['EU (London) · eu-west-1', 'eu-west-2'],
      ['EU (Frankfurt) · eu-central-1', 'eu-central-1'],
      ['Asia Pacific (Tokyo) · ap-northeast-1', 'ap-northeast-1'],
      ['Asia Pacific (Seoul) · ap-northeast-2', 'ap-northeast-2'],
      ['Asia Pacific (Singapore) · ap-southeast-1', 'ap-southeast-1'],
      ['Asia Pacific (Mumbai) · ap-south-1', 'ap-south-1'],
      ['South America (São Paulo) · sa-east-1', 'sa-east-1']
    ]
  end
end
