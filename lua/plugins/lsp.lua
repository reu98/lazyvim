-- LSP configuration
-- Inlay hints: tắt cho TS (verbose), bật cho Go/Rust (hữu ích)
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false }, -- Tắt global, bật per-server bên dưới
      servers = {
        -- ── Go ───────────────────────────────────────────
        gopls = {
          settings = {
            gopls = {
              -- Bật inlay hints cho Go (type inference, parameter names)
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                unusedparams = true,
                shadow = true,
                nilness = true,
                unusedwrite = true,
                useany = true,
              },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },
        -- ── TypeScript ───────────────────────────────────
        -- vtsls (LazyVim default) hoặc ts_ls
        vtsls = {
          settings = {
            typescript = {
              -- Tắt inlay hints cho TS — quá verbose
              inlayHints = {
                parameterNames = { enabled = "none" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = false },
              },
              preferences = {
                importModuleSpecifier = "relative",
              },
            },
            javascript = {
              inlayHints = {
                parameterNames = { enabled = "none" },
                parameterTypes = { enabled = false },
                variableTypes = { enabled = false },
                propertyDeclarationTypes = { enabled = false },
                functionLikeReturnTypes = { enabled = false },
                enumMemberValues = { enabled = false },
              },
            },
          },
        },
      },
    },
  },
}