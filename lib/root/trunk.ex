defmodule Root.Trunk do

  def call do
    Root.Leaf.call
  end

end
