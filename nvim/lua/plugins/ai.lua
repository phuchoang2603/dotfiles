return {
  {
    "NickvanDyke/opencode.nvim",
    dependencies = { "folke/snacks.nvim" },
    init = function()
      -- Configure opencode.nvim via global variable (not opts/setup)
      vim.g.opencode_opts = {
        auto_reload = true,
        provider = {
          enabled = "snacks",
        },
      }
    end,
    keys = {
      {
        "<leader>oa",
        function()
          require("opencode").ask()
        end,
        mode = "n",
        desc = "OpenCode ask",
      },
      {
        "<leader>oa",
        function()
          require("opencode").ask("@this: ")
        end,
        mode = "v",
        desc = "OpenCode ask with selection",
      },
      {
        "<leader>op",
        function()
          require("opencode").select()
        end,
        mode = { "n", "v" },
        desc = "OpenCode select prompt",
      },
    },
  },
}
