<p align="center">
  <a href="https://twitter.com/ProctorUEng">
    <img src="https://s3-us-west-2.amazonaws.com/dev-team-resources/storm-wordmark.svg" width=320 height=125>
  </a>

  <p align="center">
    self-hosted website monitoring service.
  </p>
</p>

<br>

> Storm is a 100% open-source, internationalized, platform that provides a self-hosted monitoring
service to your web apps. It provides Slack notifications, AWS server reboot
within Slack, and many more useful features.

## Table of contents

- [Status](#status)
- [Deploy to Heroku](#deploy-to-heroku)
- [To Do](#to-do)
- [Developing](#developing)
- [Credits](#credits)

## Status

[![CircleCI](https://circleci.com/gh/ProctorU/storm.svg?style=svg)](https://circleci.com/gh/ProctorU/storm)

## Deploy to Heroku

> Be sure to enable the "worker" resource after successfully deploying.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## To Do
- [x] Edit websites
- [x] Reboot websites (servers, via AWS)
- [x] Make sure entire set is internationalized.
- [x] Remove Stats link
- [x] Add Ping callback for Notifiers
- [ ] Build Storm-bot (Slack bot) API (website statuses, website reboots, etc.)
- [ ] Build Chrome new-tabs extension.
- [ ] Build iOS/Android app.

## Developing

1. Thank you! We love [our contributors](https://github.com/ProctorU/storm/graphs/contributors)!
1. Clone the repository.
1. Install missing dependencies: `bundle install`.
1. Setup your database: `rails db:setup`.
1. Start your server with foreman: `foreman start -f Procfile.dev`.
1. Make your changes in a thoughtfully-named branch.
1. Ensure 1:1 test coverage.
1. Submit a [Pull Request](https://github.com/ProctorU/storm/pulls)!
1. Celebrate! :tada:

## Credits

Storm is maintained and funded by [ProctorU](https://twitter.com/ProctorU),
a simple online proctoring service that allows you to take exams or
certification tests at home.

<br>

<p align="center">
  <a href="https://twitter.com/ProctorUEng">
    <img src="https://s3-us-west-2.amazonaws.com/dev-team-resources/procki-eyes.svg" width=108 height=72>
  </a>

  <h3 align="center">
    <a href="https://twitter.com/ProctorUEng">ProctorU Engineering & Design</a>
  </h3>
</p>
