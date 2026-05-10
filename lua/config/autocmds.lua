-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua

-- ╔══════════════════════════════════════════════════════════╗
-- ║               KITTY TAB TITLE SYNC                       ║
-- ╚══════════════════════════════════════════════════════════╝

local function get_project_name()
  local cwd = vim.fn.getcwd()
  local parts = {}
  for part in cwd:gmatch("[^/]+") do
    table.insert(parts, part)
  end
  local n = #parts
  if n >= 2 then
    local repo = parts[n]:gsub("%-", " ")
    local org = parts[n - 1]:gsub("%-", " ")
    return org .. " – " .. repo
  end
  return parts[n] and parts[n]:gsub("%-", " ") or ""
end

local kitty_group = vim.api.nvim_create_augroup("KittyTabTitle", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  group = kitty_group,
  callback = function()
    local title = get_project_name()
    vim.fn.system("kitty @ set-tab-title '" .. title .. "'")
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  group = kitty_group,
  callback = function()
    vim.fn.system("kitty @ set-tab-title ''")
  end,
})

-- ╔══════════════════════════════════════════════════════════╗
-- ║               AUTO BEHAVIORS                             ║
-- ╚══════════════════════════════════════════════════════════╝

local auto_group = vim.api.nvim_create_augroup("CustomAutocmds", { clear = true })

-- Highlight khi yank (flash vàng khi copy)
vim.api.nvim_create_autocmd("TextYankPost", {
  group = auto_group,
  callback = function()
    vim.highlight.on_yank({ higroup = "IncSearch", timeout = 200 })
  end,
})

-- Auto resize splits khi resize terminal/kitty window
vim.api.nvim_create_autocmd("VimResized", {
  group = auto_group,
  command = "tabdo wincmd =",
})

-- Đóng một số buffer đặc biệt bằng q
vim.api.nvim_create_autocmd("FileType", {
  group = auto_group,
  pattern = { "help", "man", "notify", "qf", "checkhealth", "spectre_panel" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
  end,
})

-- Tự bật spell cho markdown, git commit
vim.api.nvim_create_autocmd("FileType", {
  group = auto_group,
  pattern = { "markdown", "gitcommit", "text" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.wrap = true
  end,
})

-- Tự tạo parent directory khi save file mới
vim.api.nvim_create_autocmd("BufWritePre", {
  group = auto_group,
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})