defmodule Root do
  def all do
    Root.Leaf.call()
  end
end
