-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local map = vim.keymap.set

-- ╔══════════════════════════════════════════════════════════╗
-- ║               AI CLI INTEGRATION (KITTY)                 ║
-- ╚══════════════════════════════════════════════════════════╝
-- Dùng kitty remote control để mở AI tools trong kitty window/tab
-- Giữ Neovim nguyên vẹn, AI chạy bên cạnh

-- Mở Claude Code trong kitty window mới (cùng project dir)
map("n", "<leader>ac", function()
  vim.fn.system("kitty @ launch --type=window --cwd=current claude")
end, { desc = "Claude Code (kitty window)" })

-- Mở Claude Code trong kitty tab mới
map("n", "<leader>aC", function()
  vim.fn.system("kitty @ launch --type=tab --cwd=current claude")
end, { desc = "Claude Code (kitty tab)" })

-- Mở Codex CLI trong kitty window mới
map("n", "<leader>ax", function()
  vim.fn.system("kitty @ launch --type=window --cwd=current codex")
end, { desc = "Codex CLI (kitty window)" })

-- Gửi visual selection tới Claude Code qua stdin
-- Select text → <leader>as → Claude nhận context
map("v", "<leader>as", function()
  -- Lấy selected text
  local lines = vim.fn.getregion(vim.fn.getpos("v"), vim.fn.getpos("."), { type = vim.fn.mode() })
  local text = table.concat(lines, "\n")
  local file = vim.fn.expand("%:.")
  local lnum = vim.fn.line("v")
  local prompt = string.format("Review this code from %s:%d\\n```\\n%s\\n```", file, lnum, text)
  -- Gửi tới Claude Code trong window mới
  vim.fn.system(string.format("kitty @ launch --type=window --cwd=current claude '%s'", prompt:gsub("'", "'\\''")))
end, { desc = "Send selection to Claude" })

-- ╔══════════════════════════════════════════════════════════╗
-- ║               EDITOR ESSENTIALS                          ║
-- ╚══════════════════════════════════════════════════════════╝

-- Copy đường dẫn file relative (hữu ích khi paste vào Claude/Codex)
map("n", "<leader>fp", function()
  local path = vim.fn.expand("%:.")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy relative path" })

-- Copy đường dẫn file:line (paste vào terminal → nvim file:line)
map("n", "<leader>fP", function()
  local path = vim.fn.expand("%.") .. ":" .. vim.fn.line(".")
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end, { desc = "Copy path:line" })

-- ── Better movement ──────────────────────────────────────
-- Di chuyển dòng trong visual mode (đã có trong LazyVim nhưng confirm)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- Center screen khi search/jump
map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Prev search result (centered)" })
map("n", "<C-d>", "<C-d>zz", { desc = "Half page down (centered)" })
map("n", "<C-u>", "<C-u>zz", { desc = "Half page up (centered)" })

-- ── Quick toggles ────────────────────────────────────────
map("n", "<leader>uw", "<cmd>set wrap!<CR>", { desc = "Toggle word wrap" })
map("n", "<leader>us", "<cmd>set spell!<CR>", { desc = "Toggle spell check" })
map("n", "<leader>uc", "<cmd>set conceallevel=0<CR>", { desc = "Conceal off" })

-- ── Kitty window navigation ──────────────────────────────
-- Neovim chạy trong 1 kitty window duy nhất, dùng Ctrl+Opt+hjkl
-- (đã map trong kitty.conf) để nhảy giữa nvim ↔ terminal ↔ AI CLI.
-- Không cần map thêm ở đây vì kitty native handling đã xử lý.

-- ── Quick save ───────────────────────────────────────────
map({ "n", "i", "v", "s" }, "<C-s>", "<cmd>w<CR><esc>", { desc = "Save file" })