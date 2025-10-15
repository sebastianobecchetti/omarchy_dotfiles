-- La funzione per rinominare (LSP Rename)
-- Nota: 'bufnr' deve essere fornito dalla funzione on_attach del tuo LSP client.
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { desc = "[R]ename Symbol" })

-- Funzione principale per Salvare ed Eseguire il File/Progetto con <F10>
vim.keymap.set("n", "<F10>", function()
  -- Salva il file corrente
  vim.cmd("write")

  -- Ottieni info sul file corrente
  local file = vim.fn.expand("%:p")
  local filename_no_ext = vim.fn.expand("%:t:r")
  local filetype = vim.bo.filetype
  local current_dir = vim.fn.expand("%:p:h")

  -- Crea uno split orizzontale in tmux (viene eseguito prima di tutto)
  os.execute("tmux split-window -v")

  -- Costruisci il comando da eseguire
  local cmd = ""
  local build_dir = os.getenv("HOME") .. "/.cache/nvim_build"

  if filetype == "python" then
    -- PYTHON: Esegui il file
    cmd = 'python3 "' .. file .. '"'
  elseif filetype == "rust" then
    -- RUST: Trova la root del progetto Cargo e usa 'cargo run'
    local cargo_root = vim.fn.systemlist("cargo locate-project --message-format plain 2>/dev/null")[1]
    if cargo_root and cargo_root ~= "" then
      local dir = vim.fn.fnamemodify(cargo_root, ":h")
      cmd = 'cd "' .. dir .. '" && cargo run'
    else
      print("Cargo project non trovato. Apertura della directory.")
    end
  elseif filetype == "c" or filetype == "cpp" then
    -- C/C++: Compila con clang/clang++ e runna
    os.execute("mkdir -p " .. build_dir)
    local compiler = filetype == "c" and "clang" or "clang++"
    local output_path = build_dir .. "/" .. filename_no_ext

    -- Compile e run solo se la compilazione va a buon fine (&&)
    cmd = string.format('%s -Wall "%s" -o "%s" && "%s"', compiler, file, output_path, output_path)
  elseif filetype == "java" then
    -- JAVA (MAVEN): Trova la root risalendo l'albero di directory
    local project_dir
    local current_path = current_dir -- Iniziamo dalla directory del file corrente

    -- Funzione per trovare la root di Maven risalendo la directory
    local function find_maven_root()
      -- Cicla risalendo finché non raggiunge la root "/"
      while current_path and current_path ~= "/" do
        -- Controlla se 'pom.xml' esiste nella directory corrente
        local pom_path = current_path .. "/pom.xml"
        if vim.fn.filereadable(pom_path) == 1 then
          return current_path
        end

        -- Risali di un livello (prendi la directory padre)
        local parent_path = vim.fn.fnamemodify(current_path, ":h")

        -- Se la directory padre è la stessa (siamo alla root), ferma il ciclo
        if parent_path == current_path then
          break
        end
        current_path = parent_path
      end
      return nil -- Non trovato
    end

    project_dir = find_maven_root()

    if project_dir then
      -- Comando Maven standard
      cmd = 'cd "' .. project_dir .. '" && mvn clean compile && mvn javafx:run'
    else
      print("File pom.xml non trovato. Apertura della directory.")
    end
  end

  -- Esecuzione finale del comando in tmux
  if cmd ~= "" then
    -- Esegue il comando specifico
    local tmux_cmd = 'cd "' .. current_dir .. '" && ' .. cmd
    os.execute("tmux send-keys '" .. tmux_cmd .. "' C-m")
  else
    -- FALLBACK: Se nessun comando specifico è definito, apre solo la directory.
    os.execute("tmux send-keys 'cd \"" .. current_dir .. "\"' C-m")
  end
end, { desc = "Save and run current file or open tmux in current directory (Multi-Lang Support)" })
