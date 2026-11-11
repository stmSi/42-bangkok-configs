-- Keep your 42 login and email private: configure them in your shell, not Git.
-- See README.md for FT42_LOGIN and FT42_EMAIL setup.
local login = vim.env.FT42_LOGIN or ""
local email = vim.env.FT42_EMAIL or ""

return {
  {
    "42Paris/42header",
    enabled = login:match("^[%w_.-]+$") ~= nil
      and email:match("^[^%s@]+@[^%s@]+%.[^%s@]+$") ~= nil,
    init = function()
      vim.g.user42 = login
      vim.g.mail42 = email
    end,
    cmd = "Stdheader",
    keys = {
      { "<F1>", "<cmd>Stdheader<cr>", desc = "Insert/update 42 header" },
    },
  },
}
