return {

  {
    "folke/snacks.nvim",
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {
      image = { enabled = true },
      picker = { enabled = true },
    },
  },

  {
    "folke/ts-comments.nvim",
    opts = {},
    event = "VeryLazy",
  },

  { "wakatime/vim-wakatime", lazy = false, enabled = false },

  { "github/copilot.vim", event = "VeryLazy" },
}
