return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = false,
        auto_trigger = true,
        keymap = {
          accept = "<Tab>", -- oppure scegli <Tab>, <C-y> o altro
          next = "<C-j>",
          prev = "<C-k>",
          dismiss = "<C-h>",
        },
      },
      panel = { enabled = false }, -- se vuoi disabilitare il pannello laterale
    })
  end,
}
