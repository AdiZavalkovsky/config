-- auto install packer if not installed
local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
    return
end

return packer.startup(function(use)
    use("wbthomason/packer.nvim")
    --lua functions that many plugins use

    -- use("bluz71/vim-nightfly-guicolors") -- preferd olorscheme
    -- use { "catppuccin/nvim", as = "catppuccin" }
    use { "ellisonleao/gruvbox.nvim" }

    -- tmux & split window navigation
    use("christoomey/vim-tmux-navigator")
    -- window manager
    use("szw/vim-maximizer")
    --essential plugins
    use("tpope/vim-surround")
    use("vim-scripts/ReplaceWithRegister")

    -- commenting with gc
    use("numToStr/comment.nvim")

    -- file explorer
    use("nvim-tree/nvim-tree.lua")
    -- icons
    use("kyazdani42/nvim-web-devicons")

    -- statusline
    use("nvim-lualine/lualine.nvim")

    -- fuzzy finding w/ telescope
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" })        -- fuzzy finder

    -- autocompletion
    use("hrsh7th/nvim-cmp")   -- completion plugin
    use("hrsh7th/cmp-buffer") -- source for text in buffer
    use("hrsh7th/cmp-path")   -- source for file system paths

    -- snippets
    use("L3MON4D3/LuaSnip")             -- snippet engine
    use("saadparwaiz1/cmp_luasnip")     -- for autocompletion
    use("rafamadriz/friendly-snippets") -- useful snippets

    -- managing & installing lsp servers, linters & formatters
    use("williamboman/mason.nvim")           -- in charge of managing lsp servers, linters & formatters
    use("williamboman/mason-lspconfig.nvim") -- bridges gap b/w mason & lspconfig
    use("jayp0521/mason-null-ls.nvim")

    -- configuring lsp servers
    use("neovim/nvim-lspconfig") -- easily configure language servers
    use("hrsh7th/cmp-nvim-lsp")  -- for autocompletion
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        requires = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" },
        },
    })                                        -- enhanced lsp uis
    use("jose-elias-alvarez/typescript.nvim") -- additional functionality for typescript server (e.g. rename file & update imports)
    use("onsails/lspkind.nvim")               -- vs-code like icons for autocompletion

    -- formatting & linting
    use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
    use("jayp0521/mason-null-ls.nvim")     -- bridges gap b/w mason & null-ls

    -- treesitter configuration
    use({
        "nvim-treesitter/nvim-treesitter",
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

    -- auto closing
    use("windwp/nvim-autopairs")                                 -- autoclose parens, brackets, quotes, etc...
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

    use({ 'Vigemus/iron.nvim' })

    -- tabs
    use('romgrk/barbar.nvim')
    use 'nvim-tree/nvim-web-devicons' -- OPTIONAL: for file icons
    use 'lewis6991/gitsigns.nvim'     -- OPTIONAL: for git status)

    --git
    use("NeogitOrg/neogit")
    use("nvim-lua/plenary.nvim")  -- required
    use("sindrets/diffview.nvim") -- optional - Diff integration
    use { 'rhysd/git-messenger.vim',
        config = function()
            vim.g.git_messenger_include_diff = 'current'
        end }
    use('tpope/vim-fugitive')

    -- test
    use{'nvim-neotest/neotest',
        requires = {
            "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter"
        }}
    use("nvim-neotest/neotest-python")

    if packer_bootstrap then
        require("packer").sync()
    end

    -- db integration
    use("tpope/vim-dadbod")
    use("kristijanhusak/vim-dadbod-ui")
    use("kristijanhusak/vim-dadbod-completion")

    use("RaafatTurki/corn.nvim")
end)
