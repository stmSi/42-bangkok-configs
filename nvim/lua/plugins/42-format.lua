-- Use the 42-specific formatter instead of clang-format for C.
-- Install the executable separately: pipx install c-formatter-42
return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        c = { "c_formatter_42" },
      },
      formatters = {
        c_formatter_42 = {
          command = "c_formatter_42",
          stdin = true,
        },
      },
    },
  },
}
