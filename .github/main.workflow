workflow "New workflow" {
  on = "push"
  resolves = ["GitHub Action for Heroku", "new-action"]
}

action "GitHub Action for npm" {
  uses = "actions/npm@3c8332795d5443adc712d30fa147db61fd520b5a"
}

action "HTTP client" {
  uses = "swinton/httpie.action@02571a073b9aaf33930a18e697278d589a8051c1"
  needs = ["GitHub Action for npm"]
}

action "Filters for GitHub Actions" {
  uses = "actions/bin/filter@c6471707d308175c57dfe91963406ef205837dbd"
  needs = ["HTTP client"]
}

action "GitHub Action for Heroku" {
  uses = "actions/heroku@6db8f1c22ddf6967566b26d07227c10e8e93844b"
  needs = ["HTTP client"]
}

action "py" {
  uses = "py"
  needs = ["Filters for GitHub Actions"]
}

action "new-action" {
  uses = "owner/repo/path@ref"
  needs = ["py"]
}
