defmodule OutsideRoot do
  alias Root.{Leaf, Test}

  def call do
    Root.all()
  end

  def bar do
    Root.call()
  end

  def asd do
    Integer.is_even(2) && __MODULE__.Sub.call()
  end
end
