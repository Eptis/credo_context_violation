# This file contains the configuration for Credo and you are probably reading
# this after creating it with `mix credo.gen.config`.
#
# If you find anything wrong or unclear in this file, please report an
# issue on GitHub: https://github.com/rrrene/credo/issues
#
%{
  #
  # You can have as many configs as you like in the `configs:` field.
  configs: [
    %{
      #
      # Run any exec using `mix credo -C <name>`. If no exec name is given
      # "default" is used.
      #
      name: "default",
      #
      # These are the files included in the analysis:
      files: %{
        #
        # You can give explicit globs or simply directories.
        # In the latter case `**/*.{ex,exs}` will be used.
        #
        included: ["lib/", "src/", "test/", "web/", "apps/"],
        excluded: [~r"/_build/", ~r"/deps/", ~r"/node_modules/", "lib/context_violation.ex"]
      },
      #
      # If you create your own checks, you must specify the source files for
      # them here, so they can be loaded by Credo before running the analysis.
      #
      requires: [
        "lib/context_violation.ex"
      ],
      #
      # If you want to enforce a style guide and need a more traditional linting
      # experience, you can change `strict` to `true` below:
      #
      strict: true,
      #
      # If you want to use uncolored output by default, you can change `color`
      # to `false` below:
      #
      color: true,
      #
      # You can customize the parameters of any check by adding a second element
      # to the tuple.
      #
      # To disable a check put `false` as second element:
      #
      #     {Credo.Check.Design.DuplicatedCode, false}
      #
      checks: [
        #
        ## Consistency Checks
        #
        {Credo.Check.Consistency.ExceptionNames, false},
        {Credo.Check.Consistency.LineEndings, false},
        {Credo.Check.Consistency.ParameterPatternMatching, false},
        {Credo.Check.Consistency.SpaceAroundOperators, false},
        {Credo.Check.Consistency.SpaceInParentheses, false},
        {Credo.Check.Consistency.TabsOrSpaces, false},

        #
        ## Design Checks
        #
        # You can customize the priority of any check
        # Priority values are: `low, normal, high, higher`
        #
        {Credo.Check.Design.AliasUsage,
         [priority: :low, if_nested_deeper_than: 2, if_called_more_often_than: 0]},
        # You can also customize the exit_status of each check.
        # If you don't want TODO comments to cause `mix credo` to fail, just
        # set this value to 0 (zero).
        #
        {Credo.Check.Design.TagTODO, [exit_status: 2]},
        {Credo.Check.Design.TagFIXME, false},

        #
        ## Readability Checks
        #
        {Credo.Check.Readability.AliasOrder, false},
        {Credo.Check.Readability.FunctionNames, false},
        {Credo.Check.Readability.LargeNumbers, false},
        {Credo.Check.Readability.MaxLineLength, [priority: :low, max_length: 120]},
        {Credo.Check.Readability.ModuleAttributeNames, false},
        {Credo.Check.Readability.ModuleDoc, false},
        {Credo.Check.Readability.ModuleNames, false},
        {Credo.Check.Readability.ParenthesesInCondition, false},
        {Credo.Check.Readability.ParenthesesOnZeroArityDefs, false},
        {Credo.Check.Readability.PredicateFunctionNames, false},
        {Credo.Check.Readability.PreferImplicitTry, false},
        {Credo.Check.Readability.RedundantBlankLines, false},
        {Credo.Check.Readability.Semicolons, false},
        {Credo.Check.Readability.SpaceAfterCommas, false},
        {Credo.Check.Readability.StringSigils, false},
        {Credo.Check.Readability.TrailingBlankLine, false},
        {Credo.Check.Readability.TrailingWhiteSpace, false},
        {Credo.Check.Readability.VariableNames, false},

        #
        ## Refactoring Opportunities
        #
        {Credo.Check.Refactor.CondStatements, false},
        {Credo.Check.Refactor.CyclomaticComplexity, false},
        {Credo.Check.Refactor.FunctionArity, false},
        {Credo.Check.Refactor.LongQuoteBlocks, false},
        {Credo.Check.Refactor.MapInto, false},
        {Credo.Check.Refactor.MatchInCondition, false},
        {Credo.Check.Refactor.NegatedConditionsInUnless, false},
        {Credo.Check.Refactor.NegatedConditionsWithElse, false},
        {Credo.Check.Refactor.Nesting, false},
        {Credo.Check.Refactor.PipeChainStart,
         [excluded_argument_types: [:atom, :binary, :fn, :keyword], excluded_functions: []]},
        {Credo.Check.Refactor.UnlessWithElse, false},

        #
        ## Warnings
        #
        {Credo.Check.Warning.BoolOperationOnSameValues, false},
        {Credo.Check.Warning.ExpensiveEmptyEnumCheck, false},
        {Credo.Check.Warning.IExPry, false},
        {Credo.Check.Warning.IoInspect, false},
        {Credo.Check.Warning.LazyLogging, false},
        {Credo.Check.Warning.OperationOnSameValues, false},
        {Credo.Check.Warning.OperationWithConstantResult, false},
        {Credo.Check.Warning.RaiseInsideRescue, false},
        {Credo.Check.Warning.UnusedEnumOperation, false},
        {Credo.Check.Warning.UnusedFileOperation, false},
        {Credo.Check.Warning.UnusedKeywordOperation, false},
        {Credo.Check.Warning.UnusedListOperation, false},
        {Credo.Check.Warning.UnusedPathOperation, false},
        {Credo.Check.Warning.UnusedRegexOperation, false},
        {Credo.Check.Warning.UnusedStringOperation, false},
        {Credo.Check.Warning.UnusedTupleOperation, false},

        #
        # Controversial and experimental checks (opt-in, just remove `, false`)
        #
        {Credo.Check.Consistency.MultiAliasImportRequireUse, false},
        {Credo.Check.Design.DuplicatedCode, false},
        {Credo.Check.Readability.Specs, false},
        {Credo.Check.Refactor.ABCSize, false},
        {Credo.Check.Refactor.AppendSingleItem, false},
        {Credo.Check.Refactor.DoubleBooleanNegation, false},
        {Credo.Check.Refactor.VariableRebinding, false},
        {Credo.Check.Warning.MapGetUnsafePass, false},
        {Credo.Check.Warning.UnsafeToAtom, false},

        #
        # Custom checks can be created using `mix credo.gen.check`.
        #
        {Credo.Check.ContextViolation, []}
      ]
    }
  ]
}
