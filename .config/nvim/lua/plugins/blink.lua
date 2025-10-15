return {
  {
    "saghen/blink.cmp",
    opts = function(_, opts)
      opts.completion = vim.tbl_deep_extend("force", opts.completion or {}, {
        documentation = {
          auto_show = true,
          window = {
            max_width = 50,
            max_height = 10,
          },
        },
      })

      opts.keymap = vim.tbl_deep_extend("force", opts.keymap or {}, {
        -- TIP: Super-tab TAB also cycles on placeholders
        -- preset = "super-tab", -- presets: "default" | "enter" | "super-tab""
        -- ["<TAB>"] = { "select_and_accept" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-e>"] = { "hide", "fallback" },

        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<S-Tab>"] = { "snippet_backward", "fallback" },

        ["<Up>"] = { "select_prev", "fallback" },
        ["<Down>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback_to_mappings" },
        ["<C-n>"] = { "select_next", "fallback_to_mappings" },

        ["<C-b>"] = { "scroll_documentation_up", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },

        ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
      })
    end,
  },
}
