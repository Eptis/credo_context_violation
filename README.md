# ContextViolation

**This is super alpha**, it is the result of 2 hours of hacking and missing tests and configuration parameters and probably doesn't cover all the edge cases.

Credo check to check if function calls are made into a [context](https://hexdocs.pm/phoenix/contexts.html) and bypass the root modules public API.
Example: `Post.publish/2` calling a function on `Account.User`, which should go through `Account`.

## Installation

The package can be installed
by adding `credo_context_violation` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:credo_context_violation, "~> 0.1.0", runtime: false}
  ]
end
```

Then include it in `.credo.exs`:

```elixir
  {CredoContextViolation, []}
```

