return {
  "aPeoplesCalendar/apc.nvim",
  dependencies = {
    "rcarriga/nvim-notify",
  },
  event = "VeryLazy",
  config = function ()
    vim.keymap.set("n", "<leader>a", ":APeoplesCalendar<CR>", {})
    require("apeoplescalendar").setup() -- configuration options are described below
  end,
}
