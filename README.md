# GlobalSetLock

Let's confirm on nodes.

```
# on console A
$ iex --sname node_one -S mix
```

```
# on console B
$ iex --sname node_two -S mix
iex> Node.connect(:"node_one@your_machine_name")
iex> GlobalSetLock.lock(self())
true
```

```
# on console A
iex> GlobalSetLock.lock(self())
false
```

How it will become after node_one iex exit?


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `global_set_lock` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:global_set_lock, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/global_set_lock](https://hexdocs.pm/global_set_lock).

