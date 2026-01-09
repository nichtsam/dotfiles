return {

  {
    "folke/snacks.nvim",
    event = "VeryLazy",
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
