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
</div>

<div align="center"> <i>rublox is a Roblox web API wrapper written in Ruby. It aims to provide an object oriented interface to get and modify data from Roblox's web API. </i> </div>

<br>

# Getting Started

Authentication can be done by setting the .ROBLOSECURITY cookie through `Rublox.roblosecurity=`
```ruby
require "rublox"

Rublox.roblosecurity = "cookie"

require "dotenv"
Dotenv.load

Rublox.roblosecurity = ENV["ROBLOSECURITY"]
```

All classes representing the Roblox API models should not be initialised by the user. Instead, they are all made through methods in modules and classes.
Models can be found by searching through classes:

![](https://cdn.discordapp.com/attachments/827652175609856053/1070881521348653056/image.png)

And methods for getting the corresponding model can be found by searching through methods:

![](https://cdn.discordapp.com/attachments/827652175609856053/1070881991093919794/image.png)

# Documentation

You can access the documentation at https://rubydoc.info/gems/rublox.
