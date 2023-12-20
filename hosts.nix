{
  # these hosts can be called as: `home-manager switch --flake .#port`
  port = let sys = "x86_64-linux"; in { system = sys; profile = "home";   username = "rai"; external = ""; };
  work = let sys = "x86_64-linux"; in { system = sys; profile = "devops"; username = "rai"; external = "<REPLACE>"; };
}
