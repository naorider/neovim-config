return {
  {
    "neovim/nvim-lspconfig",
    init = function()
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      })
    end,
  },
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-buffer",
  "hrsh7th/cmp-path",
  "hrsh7th/cmp-cmdline",
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })

      -- Set configuration for specific filetype.
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- Set up lspconfig.
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("ts_ls", { capabilities = capabilities })
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("eslint")

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, { silent = true })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { silent = true })
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { silent = true })
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { silent = true })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { silent = true })
          vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { silent = true })
          vim.keymap.set("n", "<leader>ac", vim.lsp.buf.code_action, { silent = true })
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { silent = true })
          vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format, { silent = true })

          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client.name == "ts_ls" then
            -- Disable tsserver formatting because prettier is used
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false

            vim.api.nvim_buf_create_user_command(ev.buf, "OrganizeImports", function()
              client:exec_cmd({
                command = "_typescript.organizeImports",
                arguments = { vim.api.nvim_buf_get_name(ev.buf) },
                { bufnr = ev.buf },
              })
            end, {})
            vim.api.nvim_buf_create_user_command(ev.buf, "RenameFile", function()
              local source_file, target_file

              vim.ui.input({
                prompt = "Source : ",
                completion = "file",
                default = vim.api.nvim_buf_get_name(ev.buf),
              }, function(input)
                source_file = input
              end)
              vim.ui.input({
                prompt = "Target : ",
                completion = "file",
                default = source_file,
              }, function(input)
                target_file = input
              end)

              vim.lsp.util.rename(source_file, target_file)
              client:exec_cmd({
                command = "_typescript.applyRenameFile",
                arguments = {
                  {
                    sourceUri = source_file,
                    targetUri = target_file,
                  },
                },
                { bufnr = ev.buf },
              })
            end, {})
          end
        end,
      })
    end,
  },
  -- Pair input
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },
  -- Copilot
  { "github/copilot.vim" },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = {
      -- See Configuration section for options
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
  -- Toggle comments
  {
    "numToStr/Comment.nvim",
    opts = {
      -- add any options here
    },
  },
  -- Snipet
  {
    "L3MON4D3/LuaSnip",
    version = "2.*",
    build = "make install_jsregexp",
  },
  -- Lint & Format
  {
    "stevearc/conform.nvim",
    opts = {},
    config = function()
      local js_fmt = { "prettierd", "prettier", stop_after_first = true }
      require("conform").setup({
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = { "isort", "black" },
          -- You can customize some of the format options for the filetype (:help conform.format)
          rust = { "rustfmt", lsp_format = "fallback" },
          -- Conform will run the first available formatter
          javascript = js_fmt,
          typescript = js_fmt,
          javascriptreact = js_fmt,
          typescriptreact = js_fmt,
        },
        format_on_save = {
          -- These options will be passed to conform.format()
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })
    end,
  },
}
