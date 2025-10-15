return {
  "folke/noice.nvim",
  opts = {
    cmdline = {
      view = "cmdline", -- usa la visualizzazione classica in basso
    },
    views = {
      cmdline = {
        position = {
          row = -1, -- l'ultima riga (in basso)
          col = 0, -- inizia da sinistra
        },
        size = {
          width = "100%", -- larga quanto la finestra
        },
      },
    },
  },
}
