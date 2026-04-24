-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
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
    return org .. " - " .. repo
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

-- Thoát Neovim → reset để kitty tự lấy path lại
vim.api.nvim_create_autocmd("VimLeave", {
  group = kitty_group,
  callback = function()
    vim.fn.system("kitty @ set-tab-title ''")
  end,
})
