local config = {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.HINT]  = "",
      [vim.diagnostic.severity.INFO]  = "",
    },
  },
  update_in_insert = true,
  underline = true,
  severity_sort = true,
  virtual_lines = { current_line = true },
  float = {
    focusable = true,
    style  = "minimal",
    border = "single",
    source = "always",
    header = "",
    prefix = "",
    suffix = "",
  },
}
vim.diagnostic.config(config)

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
    callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")

        -- Find references for the word under your cursor.
        map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map("<leader>ws", require("fzf-lua").lsp_workspace_symbols, "[W]orkspace [S]ymbols")

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")

        -- Opens a popup that displays documentation about the word under your cursor
        --  See `:help K` for why this keymap.
        map("K", vim.lsp.buf.hover, "Hover Documentation")

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })
        end
    end,
})


require("blink.cmp").setup({
    -- All presets have the following mappings:
    -- C-space: Open menu or open docs if already open
    -- C-n/C-p or Up/Down: Select next/previous item
    -- C-e: Hide menu
    -- C-k: Toggle signature help (if signature.enabled = true)
    keymap = { preset = 'default' },
    appearance = {
        nerd_font_variant = 'mono'
    },
    completion = { documentation = { auto_show = false } },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        per_filetype = {
          sql = { 'snippets', 'dadbod', 'buffer' },
        },
        -- add vim-dadbod-completion to your completion providers
        providers = {
          dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
        },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" }
})

-- Rust
local bufnr = vim.api.nvim_get_current_buf()
vim.g.rustaceanvim = {
  -- Plugin configuration
  tools = {
  },
  -- LSP configuration
  server = {
    on_attach = function(client, bufnr)
      vim.keymap.set(
          "n", "<leader>ca", 
          function()
              vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
              -- or vim.lsp.buf.codeAction() if you don't want grouping.
          end,
          { silent = true, buffer = bufnr }
      )
      vim.keymap.set(
          "n", "K",  -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
          function()
              vim.cmd.RustLsp({'hover', 'actions'})
          end,
          { silent = true, buffer = bufnr }
      )
      vim.keymap.set(
          "n", "J",  -- Override Neovim's default join lines behavior
          function()
              vim.cmd.RustLsp('joinLines')
          end,
          { silent = true, buffer = bufnr }
      )
      -- Previous error
      vim.keymap.set(
          "n", "[e",
          function()
            vim.diagnostic.jump { count = -1, severity = vim.diagnostic.severity.ERROR }
          end,
          { silent = true, buffer = bufnr }
      )
      -- Next error
      vim.keymap.set(
          "n", "]e",
          function()
            vim.diagnostic.jump { count = 1, severity = vim.diagnostic.severity.ERROR }
          end,
          { silent = true, buffer = bufnr }
      )
      vim.lsp.inlay_hint.enable(true, { buffer = bufnr })
    end,
    default_settings = {
      -- rust-analyzer language server configuration
      ['rust-analyzer'] = {
        cargo = { allFeatures = true },
        checkOnSave = true,
        check = {
          command = "clippy"
        }
      },
    },
  },
  -- DAP configuration
  dap = {
  },
}

vim.lsp.config['gopls'] = {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
    settings = {
        gopls = {
            hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
            },
        },
    },
}
vim.lsp.enable('gopls')
