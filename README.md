# Überauth GitHub

> Überauth strategy for authenticating with GitHub.

### Setup

Create an application in GitHub for you to use.

Register a new application at: [your github developer page](https://github.com/settings/developers) and get the `client_id` and `client_secret`.

Include the provider in your configuration for Ueberauth

```elixir
config :ueberauth, Ueberauth,
  providers: [
    github: [ { Ueberauth.Strategy.Github, [] } ]
  ]
```

Then include the configuration for github.

```elixir
config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("GITHUB_CLIENT_ID"),
  client_secret: System.get_env("GITHUB_CLIENT_SECRET")
```

If you haven't already, create a pipeline and setup routes for your callback handler

```elixir
pipeline :auth do
  Ueberauth.plug "/auth"
end

scope "/auth" do
  pipe_through [:browser, :auth]

  get "/:provider/callback", AuthController, :callback
end
```

Create an endpoint for the callback where you will handle the `Ueberauth.Auth` struct

```elixir
defmodule MyApp.AuthController do
  use MyApp.Web, :controller

  def callback_phase(%{ assigns: %{ ueberauth_failure: fails } } = conn, _params) do
    # do things with the failure
  end

  def callback_phase(%{ assigns: %{ ueberauth_auth: auth } } = conn, params) do
    # do things with the auth
  end
end
```

You can edit the behaviour of the Strategy by including some options when you register your provider.

To set the `uid_field`

```elixir
config :ueberauth, Ueberauth,
  providers: [
    github: [ { Ueberauth.Strategy.Github, [uid_field: :email] } ]
  ]
```

Default is `:login`

To set the default 'scopes' (permissions):

```elixir
config :ueberauth, Ueberauth,
  providers: [
    github: [ { Ueberauth.Strategy.Github, [default_scope: "user,public_repo"] } ]
  ]
```

Deafult is "user,public_repo"

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

1. Add ueberauth_github to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:ueberauth_github, "~> 0.1.0"}]
    end
    ```
