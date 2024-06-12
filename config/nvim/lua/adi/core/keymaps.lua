vim.g.mapleader = ","
local keymap = vim.keymap -- fir cibcusebess

-- general keymaps
keymap.set("i", "jk", "<ESC>")
keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "x", '"_x')

keymap.set("n", "<leader>+", "<C-a>")
keymap.set("n", "<leader>-", "<C-x>")

keymap.set("n", "<leader>pv", ":q<CR>")

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- Go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- Go to previous tab

-- plugin keymaps
-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")
-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags

--dbui
vim.api.nvim_set_keymap('n', '<leader>db', ':DBUIToggle<CR>', { noremap = true, silent = true })

-- acli test current fuction
vim.api.nvim_set_keymap('n', '<leader>atf', ':lua TestCurrentFunction()<CR>', { noremap = true, silent = true })

function TestCurrentFunction()
    local cwd = vim.fn.expand('%:p:h')
    local relative_path = vim.fn.expand('%:~:.')
    local cmd = string.format("/Users/adi.zavalkovsky/.pyenv/shims/python3 /Users/adi.zavalkovsky/code/armis/dev_tools/dtest.py %s --lineno=%d --from-pycharm", relative_path, vim.fn.line('.'))
    vim.cmd('split')
    vim.cmd('term ' .. cmd)
    -- vim.cmd('autocmd BufWinLeave <buffer> q:lua vim.cmd("q")')
end

-- acli pylint
vim.api.nvim_set_keymap('n', '<leader>apl', ':lua AcliPylint()<CR>', { noremap = true, silent = true })

function AcliPylint()
    local cwd = vim.fn.expand('%:p:h')
    local relative_path = vim.fn.expand('%:~:.')
    local cmd = string.format("acli feature pylint %s", relative_path)
    vim.cmd('split')
    vim.cmd('term ' .. cmd)
end
--git
-- keymap.set("n", "<leader>gb", "<cmd>GitMessenger<cr>") -- Open git commit message
