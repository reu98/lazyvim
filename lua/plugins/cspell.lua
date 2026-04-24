return {
  "neovim/nvim-lspconfig",
  opts = {
    vim.lsp.enable("cspell_ls"),
    vim.lsp.config("cspell_ls", {
      cmd = { "cspell-lsp", "--stdio" },
      filetypes = {
        "typescript",
        "typescriptreact",
        "javascript",
        "javascriptreact",
        "lua",
        "python",
        "go",
        "html",
        "css",
        "json",
        "yaml",
        "markdown",
        "gitcommit",
      },
      root_markers = { ".git", "package.json" },
    }),
  },
}
