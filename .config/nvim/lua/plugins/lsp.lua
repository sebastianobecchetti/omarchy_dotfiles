return {
  -- Mason: installa automaticamente gli strumenti
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "pyright",
        "ruff",
        "rust-analyzer",
        "codelldb",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
        "jdtls",
        "clangd",
        "clang-format",
      },
    },
  },

  -- Configurazioni dei linguaggi
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- PYTHON
        pyright = {},
      },
    },
  },
}
