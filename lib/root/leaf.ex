defmodule Root.Leaf do
  def call do
    []
  end

  def callz do
    OutsideRoot.bar()
    OutsideRoot.call()
  end
end
