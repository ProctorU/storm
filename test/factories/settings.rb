FactoryGirl.define do
  factory :setting do
    aws_key('aws_key')
    aws_secret('aws_secret')
    slack_url('127.0.0.1/slack')
  end
end
