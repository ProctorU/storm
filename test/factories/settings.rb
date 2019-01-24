FactoryBot.define do
  factory :setting do
    aws_key { 'aws_key' }
    aws_secret { 'aws_secret' }
    slack_url { 'http://127.0.0.1/slack' }
  end

  trait(:with_secondary_slack_url) do
    secondary_slack_url { 'http://127.0.0.1/slack' }
  end
end
