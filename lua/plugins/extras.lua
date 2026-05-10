-- Extra plugins cho full-stack + AI CLI workflow
return {
  -- ╔══════════════════════════════════════════════════════════╗
  -- ║          THAY THẾ VSCODE EXTENSIONS                      ║
  -- ╚══════════════════════════════════════════════════════════╝

  -- ── Code Spell Checker (thay vscode-spell-checker) ─────
  -- cspell qua nvim-lint — check spelling trong code, comments, strings
  -- Tạo file .cspell.json ở root project để custom dictionary
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        javascript = { "cspell" },
        typescript = { "cspell" },
        typescriptreact = { "cspell" },
        javascriptreact = { "cspell" },
        go = { "cspell" },
        rust = { "cspell" },
        lua = { "cspell" },
        markdown = { "cspell" },
      },
      linters = {
        cspell = {
          -- Chỉ show warning, không phải error
          condition = function(ctx)
            -- Tắt cspell cho file quá lớn (> 500KB)
            local fsize = vim.fn.getfsize(ctx.filename)
            return fsize > 0 and fsize < 500000
          end,
        },
      },
    },
  },

  -- ── Turbo Console Log (thay vscode extension) ─────────
  -- g?v → insert debug print dưới cursor với biến
  -- g?V → insert ở trên cursor
  -- g?d → xóa tất cả debug lines trong file
  {
    "andrewferrier/debugprint.nvim",
    keys = {
      { "g?v", mode = { "n", "x" }, desc = "Debug print variable below" },
      { "g?V", mode = { "n", "x" }, desc = "Debug print variable above" },
      { "g?d", desc = "Delete all debug prints" },
      { "g?p", desc = "Debug print plain below" },
      { "g?P", desc = "Debug print plain above" },
    },
    opts = {
      keymaps = {
        normal = {
          variable_below = "g?v",
          variable_above = "g?V",
          plain_below = "g?p",
          plain_above = "g?P",
          delete_debug_prints = "g?d",
        },
        visual = {
          variable_below = "g?v",
          variable_above = "g?V",
        },
      },
      -- Prefix dễ tìm và xóa
      print_tag = "🔍 DEBUG",
    },
  },

  -- ╔══════════════════════════════════════════════════════════╗
  -- ║          AI CLI INTEGRATION                              ║
  -- ╚══════════════════════════════════════════════════════════╝

  -- ── flatten.nvim — reuse Neovim instance từ terminal ───
  -- Khi Claude Code hoặc Codex chạy `nvim file.lua` hoặc `git commit`,
  -- file mở trong Neovim instance hiện tại thay vì spawn cái mới.
  {
    "willothy/flatten.nvim",
    lazy = false,
    priority = 1001,
    opts = {
      window = {
        open = "alternate",
      },
      hooks = {
        -- pipe_path BẮT BUỘC cho kitty — tạo/tìm server socket theo KITTY_PID
        pipe_path = function()
          -- Nested Neovim terminal (`:term`)
          if vim.env.NVIM then
            return vim.env.NVIM
          end
          -- Kitty terminal — tất cả windows/tabs cùng 1 kitty instance
          -- sẽ mở file trong Neovim instance đầu tiên
          if vim.env.KITTY_PID then
            local addr = ("%s/%s"):format(
              vim.fn.stdpath("run"),
              "kitty.nvim-" .. vim.env.KITTY_PID
            )
            if not vim.uv.fs_stat(addr) then
              vim.fn.serverstart(addr)
            end
            return addr
          end
        end,
        post_open = function(bufnr, winnr, ft, is_blocking)
          vim.api.nvim_set_current_win(winnr)
        end,
      },
      block_for = {
        gitcommit = true,
        gitrebase = true,
      },
      integrations = {
        kitty = true,
      },
    },
  },

  -- ╔══════════════════════════════════════════════════════════╗
  -- ║          EDITOR ENHANCEMENTS                             ║
  -- ╚══════════════════════════════════════════════════════════╝

  -- ── nvim-ts-autotag — auto close/rename HTML/JSX tags ──
  { "windwp/nvim-ts-autotag", event = "InsertEnter", opts = {} },

  -- ── Colorizer — hiện màu inline cho hex/rgb ───────────
  {
    "NvChad/nvim-colorizer.lua",
    event = "BufReadPost",
    opts = {
      filetypes = {
        "css",
        "scss",
        "html",
        "javascript",
        "typescript",
        "typescriptreact",
        "javascriptreact",
        "lua",
        "toml",
        "yaml",
        "conf",
      },
      user_default_options = { tailwind = true },
    },
  },

  -- ── package-info — hiện version mới nhất inline ───────
  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    ft = "json",
    opts = {},
  },

  -- ── diffview.nvim — xem diff project như VSCode SCM ───
  -- <leader>gd mở diffview, <leader>gD đóng
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<CR>", desc = "Diffview: Open" },
      { "<leader>gD", "<cmd>DiffviewClose<CR>", desc = "Diffview: Close" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<CR>", desc = "Diffview: File history" },
      { "<leader>gF", "<cmd>DiffviewFileHistory<CR>", desc = "Diffview: Branch history" },
    },
    opts = {
      enhanced_diff_hl = true,
      view = {
        default = { layout = "diff2_horizontal" },
      },
    },
  },

  -- ── refactoring.nvim ────────────────────────────────────
  -- Dùng LazyVim extra "lazyvim.plugins.extras.editor.refactoring" (đã enable trong lazyvim.json)
  -- Keymaps mặc định từ extra:
  --   <leader>rs  Select Refactor (menu chọn action)
  --   <leader>ri  Inline Variable
  --   <leader>rf  Extract Function
  --   <leader>rF  Extract Function To File
  --   <leader>rx  Extract Variable
  --   <leader>rp  Debug Print Variable
  --   <leader>rc  Debug Cleanup
  -- Không cần config thủ công — extra đã handle hết

  -- ── todo-comments highlight ────────────────────────────
  -- LazyVim đã có, nhưng thêm custom keywords cho AI workflow
  {
    "folke/todo-comments.nvim",
    opts = {
      keywords = {
        AI = { icon = "🤖", color = "hint", alt = { "CLAUDE", "CODEX", "GPT" } },
      },
    },
  },
}