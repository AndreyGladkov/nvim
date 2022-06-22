-- https://github.com/lukas-reineke/indent-blankline.nvim

vim.opt.list = true

require("ibl").setup {
  exclude = {
    filetypes = { "help", "dashboard", "packer", "NvimTree", "Trouble", "TelescopePrompt", "Float" },
    buftypes = { "terminal", "nofile", "telescope" },
  },
  indent = {
    char = "│",
  },
  scope = {
    enabled = true,
    show_start = false,
  }
}
