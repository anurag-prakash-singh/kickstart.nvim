local opt = vim.opt

-- tabs and indentation
opt.expandtab = true
opt.tabstop = 2
opt.shiftwidth = 2

-- search settings
opt.ignorecase = true -- disable case sensitive search by default
opt.smartcase = true -- if mixed case is included in the search, turns on case sensitive match

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
