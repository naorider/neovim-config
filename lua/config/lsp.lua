local M = {}

function M.setup()
  local capabilities = require("blink.cmp").get_lsp_capabilities()

  vim.lsp.config("*", {
    capabilities = capabilities,
  })

  vim.lsp.config("lua_ls", {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  })

  vim.lsp.config("ts_ls", {})

  vim.lsp.config("jsonls", {
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
        validate = { enable = true },
      },
    },
  })

  vim.lsp.enable({
    "lua_ls",
    "ts_ls",
    "eslint",
    "jsonls",
  })

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
    callback = function(ev)
      local opts = { buffer = ev.buf, silent = true }

      vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)

      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if not client or client.name ~= "ts_ls" then
        return
      end

      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.documentRangeFormattingProvider = false

      vim.api.nvim_buf_create_user_command(ev.buf, "OrganizeImports", function()
        client:exec_cmd({
          command = "_typescript.organizeImports",
          arguments = { vim.api.nvim_buf_get_name(ev.buf) },
        }, { bufnr = ev.buf })
      end, {})

      vim.api.nvim_buf_create_user_command(ev.buf, "RenameFile", function()
        local source_file = vim.api.nvim_buf_get_name(ev.buf)

        vim.ui.input({
          prompt = "Target : ",
          completion = "file",
          default = source_file,
        }, function(target_file)
          if not target_file or target_file == "" or target_file == source_file then
            return
          end

          vim.lsp.util.rename(source_file, target_file)

          client:exec_cmd({
            command = "_typescript.applyRenameFile",
            arguments = {
              {
                sourceUri = vim.uri_from_fname(source_file),
                targetUri = vim.uri_from_fname(target_file),
              },
            },
          }, { bufnr = ev.buf })
        end)
      end, {})
    end,
  })
end

return M
