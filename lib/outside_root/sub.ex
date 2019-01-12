defmodule OutsideRoot.Sub do
    def call do
      Root.call
      []
    end
end
