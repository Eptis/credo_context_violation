defmodule Credo.Check.ContextViolation do
  @moduledoc """
    Checks if modules are not violating contexts by reaching into other module namespaces.

    Modules in Elixir are namespaced and to promote proper design and make sure
    modules are loosely coupled they should only consume the public API defined
    by the top level root of the namespace.
    So Module A or Module A.B can call functions on Module B but not on
    Module B.C or Module B.C.D.

    In addition modules should only call modules in their own level in the namespace.
    This ensures that their dependencies only point downward which further ensures
    looser coupling.

  """
  require IEx

  @explanation [
    check: @moduledoc,
    params: []
  ]

  # you can configure the basics of your check via the `use Credo.Check` call
  use Credo.Check, base_priority: :high, category: :design, exit_status: 1

  def run(source_file, params \\ [])
  def run(%{filename: "test/" <> _}, _), do: []

  def run(source_file, params) do
    issue_meta = IssueMeta.for(source_file, params)

    {:ok, ast} = Credo.Code.ast(source_file)

    # # extract root_module
    root_module = Credo.Code.Module.name(ast)
    module_references = module_call_list(ast)

    illegal_modules =
      module_references
      |> Enum.filter(fn mod ->
        String.contains?(mod, ".") && !String.starts_with?(mod, "Elixir") &&
          !String.starts_with?(mod, "__MODULE__") && !String.starts_with?(mod, root_module) &&
          !share_namespace(mod, root_module)
      end)
      |> Enum.map(fn mod ->
        if String.starts_with?(mod, root_module) do
          String.split(mod, "#{root_module}.")
        else
          mod
        end
      end)

    fn_calls =
      ast
      |> extract_function_calls()
      |> illegal_function_calls(illegal_modules)

    Enum.reduce(fn_calls, [], fn f, acc ->
      [
        format_issue(issue_meta,
          message:
            "Namespace violation. Call: #{f.expanded_mod}.#{f.fun} Current namespace: #{
              root_module
            }",
          line_no: f.line,
          column: f.col,
          trigger: "#{Enum.join(f.mod)}.#{f.fun}"
        )
        | acc
      ]
    end)
  end

  def module_call_list(ast) do
    aliases = Credo.Code.Module.aliases(ast)
    modules = Credo.Code.Module.modules(ast)

    Enum.reduce(modules, aliases, fn m, acc ->
      if Enum.find(acc, fn alia -> String.ends_with?(alia, m) end) do
        acc
      else
        [m | acc]
      end
    end)
  end

  def share_namespace(mod, root_module) do
    namespace(mod) == namespace(root_module)
  end

  def namespace(mod) do
    mod
    |> String.split(".")
    |> Enum.reverse()
    |> tl()
  end

  defp illegal_function_calls(funs, illegal_modules) do
    Enum.reduce(funs, [], fn
      %{mod: [{:__MODULE__, _, _} | _]}, acc ->
        acc

      f, acc ->
        case Enum.find(illegal_modules, &String.ends_with?(&1, Enum.join(f.mod, "."))) do
          nil ->
            acc

          expanded_mod ->
            [Map.put(f, :expanded_mod, expanded_mod) | acc]
        end
    end)
  end

  defp extract_function_calls(ast) do
    Credo.Code.postwalk(ast, &extract_function_call/2, [])
  end

  defp extract_function_call(
         {:., _, [{:__aliases__, [line: l, column: c], mod}, fun]} = node,
         acc
       ) do
    {node, [%{line: l, col: c, mod: mod, fun: fun} | acc]}
  end

  defp extract_function_call(node, acc), do: {node, acc}
end
