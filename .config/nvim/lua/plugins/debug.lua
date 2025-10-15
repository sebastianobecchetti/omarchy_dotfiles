return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- necessario per dap-ui
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.40 },
              { id = "breakpoints", size = 0.20 },
              { id = "stacks", size = 0.20 },
              { id = "watches", size = 0.20 },
            },
            size = 50, -- larghezza pannello sinistro
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "console", size = 0.5 },
            },
            size = 12, -- altezza pannello inferiore
            position = "bottom",
          },
        },
      })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Continue" })
      vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Step Over" })
      vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step Into" })
      vim.keymap.set("n", "<Leader>du", dap.step_out, { desc = "Step Out" })
      vim.keymap.set("n", "<Leader>dr", dap.restart, { desc = "Restart" })
      vim.keymap.set("n", "<Leader>dx", dap.terminate, { desc = "Terminate" })
    end,
  },
}
