# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

website_count = 4
ping_count = 500
total_records = website_count * ping_count + website_count

progressbar = ProgressBar.create(total: total_records)

# create default Setting
SettingsCreator.execute

website_count.times do
  website = Website.create(
    name: Faker::App.name,
    url: Faker::Internet.url
  )

  progressbar.increment

  ping_count.times do
    Ping.create(
      website: website,
      status: [0, 1].sample,
      response_time: rand(300..1000)
    )

    progressbar.increment
  end
end

# remove any created background jobs.
Delayed::Job.delete_all
