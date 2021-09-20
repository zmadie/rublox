<div align="center">
  <img src="https://raw.githubusercontent.com/roblox-api-wrappers/.github/main/res/rublox_logo.png" alt="rublox" width="15%" height="15%"/>
</div>

<br>

<div align="center">
  <a href="https://rubygems.org/gems/rublox">
    <img alt="gem" src="https://img.shields.io/gem/dt/rublox?color=rgb%28170%2C%200%2C%200%29&logo=rubygems&style=flat-square">
  </a>

  <a href="https://rubygems.org/gems/rublox">
    <img alt="gem version" src="https://img.shields.io/gem/v/rublox?color=rgb%28170%2C%200%2C%200%29&label=gem%20version&logo=rubygems&style=flat-square">
  </a>

  <a href="https://github.com/roblox-api-wrappers/rublox/blob/main/LICENSE">
    <img alt="license: MIT" src="https://img.shields.io/github/license/roblox-api-wrappers/rublox?color=rgb%28150%2C%200%2C%200%29&logo=github&style=flat-square">
  </a>

  <img alt="commit activity" src="https://img.shields.io/github/commit-activity/m/roblox-api-wrappers/rublox?color=rgb%28170%2C%200%2C%200%29&logo=github&style=flat-square">

  <img alt="repo stars" src="https://img.shields.io/github/stars/roblox-api-wrappers/rublox?color=rgb%28170%2C%200%2C%200%29&logo=github&style=flat-square">

  <a href="https://rubydoc.info/gems/rublox">
    <img alt="docs" src="https://img.shields.io/badge/docs-rubydoc.info-aa0000?style=flat-square">
  </a>

  <a href="https://guilded.gg/roblox-api-wrappers">
    <img alt="support server" src="https://img.shields.io/badge/guilded-support%20server-aa0000.svg?style=flat-square&logo=guilded">
  </a>
</div>

<div align="center"> <i>rublox is a Roblox web API wrapper written in Ruby. It aims to provide an object oriented interface to get and modify data from Roblox's web API. </i> </div>

<br>

# Installation

Include rublox in your application's `Gemfile`

```ruby
gem "rublox", "~> 0.1.0"
```

or run

> $ gem install rublox

on your terminal.

# Getting started

The gateway to the API is the `Rublox::Client` -- MAKE THIS LINK TO DOCUMENTATION object. You can initialize it with your _.ROBLOSECURITY_ cookie if you need functionality that needs it.

```ruby
# Without a cookie
client = Rublox::Client.new
# With a cookie
client = Rublox::Client.new("_|WARNING:-DO-NOT-SHARE-THIS.--Sharing-this ...")
```

**(if you open-source/work with other people on your application, it is recommended to keep your cookie in a `.env` file and load it with a libray like [dotenv](https://rubygems.org/gems/dotenv))**

From there, you can build off your application's logic with methods provided via `Rublox::Client` --SAME HERE.

# Documentation

You can access the documentation at https://rubydoc.info/gems/rublox.
