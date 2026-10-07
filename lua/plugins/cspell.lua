return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      cspell_ls = {
        cmd = { "cspell-lsp", "--stdio", "--config", "/Users/reu98/cspell.json" },
        filetypes = {
          -- Node.js / TypeScript
          "typescript",
          "typescriptreact",
          "javascript",
          "javascriptreact",
          -- Frontend
          "html",
          "css",
          "scss",
          "less",
          "vue",
          "svelte",
          "astro",
          -- Backend
          "go",
          "rust",
          "java",
          "kotlin",
          "python",
          -- Mobile
          "swift",
          -- API, schema, database
          "graphql",
          "proto",
          "prisma",
          "sql",
          -- DevOps
          "dockerfile",
          "sh",
          "bash",
          "zsh",
          "make",
          "terraform",
          "hcl",
          "nginx",
          -- Config
          "json",
          "jsonc",
          "yaml",
          "toml",
          "xml",
          -- Docs
          "markdown",
          "gitcommit",
          -- Neovim config
          "lua",
        },
      },
    },
  },
}
