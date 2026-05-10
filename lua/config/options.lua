-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

-- ── Editor Behavior ──────────────────────────────────────
vim.opt.scrolloff = 8 -- Luôn hiện 8 dòng trên/dưới cursor
vim.opt.sidescrolloff = 8 -- 8 cột trái/phải khi nowrap
vim.opt.wrap = false -- Không wrap dòng dài
vim.opt.confirm = true -- Hỏi khi quit chưa save
vim.opt.conceallevel = 0 -- Hiện rõ markdown symbols, JSON quotes
vim.opt.linebreak = true -- Nếu bật wrap thì break tại word
vim.opt.pumblend = 10 -- Popup menu hơi trong suốt
vim.opt.winblend = 10 -- Floating window hơi trong suốt

-- ── Search ───────────────────────────────────────────────
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ── Indent ───────────────────────────────────────────────
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- ── Spell ────────────────────────────────────────────────
-- Spell check tiếng Anh, bật thủ công khi cần (zs để toggle)
vim.opt.spelllang = { "en" }
vim.opt.spell = false -- Tắt mặc định, bật per-buffer khi cần

-- ── UI ───────────────────────────────────────────────────
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true

-- ── Performance ──────────────────────────────────────────
vim.opt.updatetime = 200 -- Faster CursorHold events cho LSP hover
vim.opt.timeoutlen = 300 -- Which-key hiện nhanh hơn

-- ── Undo persistence ────────────────────────────────────
vim.opt.undofile = true
vim.opt.undolevels = 10000

-- ── Disable mouse trong Neovim — bạn dùng keyboard ─────
-- (comment lại nếu muốn mouse)
-- vim.opt.mouse = ""

-- ── Format on save behavior ─────────────────────────────
-- LazyVim tự handle qua conform.nvim, chỉ cần set autoformat
vim.g.autoformat = true

-- ── Neovide (nếu bao giờ dùng) ─────────────────────────
if vim.g.neovide then
  vim.o.guifont = "FiraCode Nerd Font Mono:h14"
  vim.g.neovide_transparency = 0.92
end