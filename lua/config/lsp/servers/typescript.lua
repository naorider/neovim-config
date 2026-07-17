local M = {}

function M.setup()
  vim.lsp.config("ts_ls", {})
end

function M.on_attach(client, bufnr)
  if client.name ~= "ts_ls" then
    return
  end

  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  vim.api.nvim_buf_create_user_command(bufnr, "OrganizeImports", function()
    client:exec_cmd({
      command = "_typescript.organizeImports",
      arguments = { vim.api.nvim_buf_get_name(bufnr) },
    }, { bufnr = bufnr })
  end, {})

  vim.api.nvim_buf_create_user_command(bufnr, "RenameFile", function()
    local source_file = vim.api.nvim_buf_get_name(bufnr)

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
      }, { bufnr = bufnr })
    end)
  end, {})
end

return M
