return {
  "numToStr/FTerm.nvim",
  config = function()
    require("FTerm").setup({
      border = "rounded",
      dimensions = {
        height = 0.9,
        width = 0.9,
      },
      -- Non è necessario modificare qui, la logica va nel keymap
    })

    -- Esempio di mapping per aprire il terminale
    vim.keymap.set("n", "<A-i>", function()
      -- Ottieni la directory di lavoro corrente di Neovim
      local current_dir = vim.fn.getcwd()
      
      -- Esegui 'toggle' passando 'cmd' per lanciare 'cd <directory> && <shell>'
      require("FTerm").toggle({
        cmd = "cd " .. current_dir .. " && $SHELL"
      })
    end, { desc = "Toggle FTerm nella cartella corrente" })
  end,
}
