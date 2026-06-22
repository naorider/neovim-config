return {
  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
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

      vim.lsp.config("ts_ls", {
        -- ts_ls 固有設定が必要になったらここに書く
      })

      vim.lsp.enable({
        "lua_ls",
        "ts_ls",
        "eslint",
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
          if not client then
            return
          end

          if client.name == "ts_ls" then
            -- formatting は conform.nvim に寄せる
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
          end
        end,
      })
    end,
  },

  -- Completion
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    opts = {
      keymap = {
        preset = "default",
      },

      appearance = {
        nerd_font_variant = "mono",
      },

      completion = {
        documentation = {
          auto_show = false,
        },
        menu = {
          auto_show = true,
        },
      },

      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },

      snippets = {
        preset = "default",
      },

      fuzzy = {
        implementation = "prefer_rust_with_warning",
      },
    },
    opts_extend = { "sources.default" },
  },

  -- Pair input
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
  },

  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    dependencies = {
      { "github/copilot.vim" },
      { "nvim-lua/plenary.nvim", branch = "master" },
    },
    build = "make tiktoken",
    opts = {},
  },

  -- Toggle comments
  {
    "numToStr/Comment.nvim",
    opts = {},
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
          python = { "isort", "black" },
          rust = { "rustfmt", lsp_format = "fallback" },
          javascript = js_fmt,
          typescript = js_fmt,
          javascriptreact = js_fmt,
          typescriptreact = js_fmt,
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
      })

      vim.keymap.set({ "n", "x" }, "<leader>fm", function()
        require("conform").format({ async = true })
      end, { silent = true })
    end,
  },

  "mfussenegger/nvim-jdtls",
}
