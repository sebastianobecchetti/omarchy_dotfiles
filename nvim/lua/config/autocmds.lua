-- 1. Salvataggio automatico su perdita di focus o cambio buffer
vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  pattern = "*",
  command = "silent! wall",
})

-- 2. Rimozione automatica di spazi finali
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[:%s/\s\+$//e]],
})

-- 3. Ridimensionamento automatico delle finestre quando cambia la dimensione del terminale
vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  command = "wincmd =",
})

-- 4. Ritorna alla posizione del cursore quando riapri un file
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line([['"]])
    if line > 0 and line <= vim.fn.line("$") then
      vim.cmd([[normal! g`"]])
    end
  end,
})

-- 5. Attivazione automatica del filetype per formattazione, LSP, ecc.
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.lua", "*.py", "*.ts", "*.js" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})

-- 6. Mostrare i numeri relativi solo in modalità normale
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.wo.relativenumber = false
  end,
})

vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    vim.wo.relativenumber = true
  end,
})

-- 7. Creazione automatica della cartella all'apertura di un nuovo file
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(event)
    local dir = vim.fn.fnamemodify(event.file, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    vim.opt_local.spell = false
  end,
})
