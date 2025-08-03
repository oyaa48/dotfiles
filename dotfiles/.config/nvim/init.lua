-- [[ BASIC SETTINGS ]] 
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.termguicolors = true

-- ✅ persistent undo
local undodir = vim.fn.stdpath("state") .. "/undo"
vim.opt.undodir = undodir
vim.opt.undofile = true
vim.fn.mkdir(undodir, "p")

-- [[ INSTALL PLUGIN MANAGER ]]
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- [[ PLUGINS ]]
require("lazy").setup({
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-lualine/lualine.nvim" },
    { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    { "neovim/nvim-lspconfig" },
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "L3MON4D3/LuaSnip" },
    { "saadparwaiz1/cmp_luasnip" },
})

-- [[ TREESITTER ]]
require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "python", "javascript", "html", "css" },
    highlight = { enable = true },
})

-- [[ LUALINE ]]
require("lualine").setup()

-- [[ TELESCOPE ]]
require("telescope").setup()

-- [[ LSP ]]
local lspconfig = require("lspconfig")
lspconfig.pyright.setup({})
lspconfig.ts_ls.setup({})
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { "vim" }
            }
        }
    }
})

-- HTML
lspconfig.html.setup({})

-- CSS
lspconfig.cssls.setup({})

-- Bash
lspconfig.bashls.setup({})

-- [[ AUTOCOMPLETE ]]
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
    })
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    print("undofile is", vim.o.undofile and "ON ✅" or "OFF ❌")
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.undofile = true
    print("🔄 Re-set undofile on VimEnter")
  end,
})

vim.cmd [[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NormalNC guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
]]
