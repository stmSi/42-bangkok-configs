-- Disable common AI inline-completion plugins; keep ordinary LSP completion.
-- Also disable any enabled 'ai.*' extras in :LazyExtras.
return {
  { "zbirenbaum/copilot.lua", enabled = false },
  { "github/copilot.vim", enabled = false },
  { "supermaven-inc/supermaven-nvim", enabled = false },
  { "Exafunction/codeium.nvim", enabled = false },
  { "monkoose/neocodeium", enabled = false },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        copilot = { enabled = false },
      },
    },
  },
  {
    "saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      -- AI providers can be appended by enabled LazyVim extras.
      if opts.sources and type(opts.sources.default) == "table" then
        local ai_sources = {
          copilot = true,
          codeium = true,
          neocodeium = true,
          supermaven = true,
          tabnine = true,
          minuet = true,
        }
        opts.sources.default = vim.tbl_filter(function(source)
          return not ai_sources[source]
        end, opts.sources.default)
      end
      if opts.completion then
        opts.completion.ghost_text = { enabled = false }
      end
    end,
  },
}
