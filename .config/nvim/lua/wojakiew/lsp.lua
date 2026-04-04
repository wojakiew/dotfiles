local keymap = vim.keymap -- for conciseness
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(event)
    local map = function(mode, keys, func, desc)
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
    end

    -- set keybinds
    map("n", "gR", "<cmd>Telescope lsp_references<CR>", "Show LSP references")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, "Show LSP definition")
    map("n", "gi", "<cmd>Telescope lsp_implementations<CR>", "Show LSP implementations")
    map("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", "Show LSP type definitions")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "See available code actions")
    map("n", "<leader>rn", vim.lsp.buf.rename, "Smart rename")
    map("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show buffer diagnostics")
    map("n", "<leader>d", vim.diagnostic.open_float, "Show line diagnostics")
    
    map("n", "[d", function()
      vim.diagnostic.jump({ count = -1, float = true })
    end, "Go to previous diagnostic")
    
    map("n", "]d", function()
      vim.diagnostic.jump({ count = 1, float = true })
    end, "Go to next diagnostic")

    map("n", "K", vim.lsp.buf.hover, "Show documentation for what is under cursor")
    map("n", "<leader>rs", ":LspRestart<CR>", "Restart LSP")

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method("textDocument/documentHighlight", event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd("LspDetach", {
            group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
            callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
            end,
        })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client:supports_method("textDocument/inlayHint", event.buf) then
        map("n", "<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "[T]oggle Inlay [H]ints")
    end
  end,
})

-- vim.lsp.inlay_hint.enable(true)

local severity = vim.diagnostic.severity

vim.diagnostic.config({
  signs = {
    text = {
      [severity.ERROR] = " ",
      [severity.WARN] = " ",
      [severity.HINT] = "󰠠 ",
      [severity.INFO] = " ",
    },
  },
})