# Runnning tests

## _Make an environment variable for your .ROBLOSECURITY cookie_

Create a `.env` file in the root of the project, it should contain the following content:

```
ROBLOSECURITY=your_roblosecurity
```

where `your_roblosecurity` is your .ROBLOSECURITY cookie.

## _Actually running the tests_

Run the `rake test` command.

> $ rake test

## _Notice_

Functionality that requires changing data in Roblox (such as updating group shouts) do not have automated tests. The bugs are uncovered by the community, so if you come across a bug, create an issue or fix it and send us a PR!
