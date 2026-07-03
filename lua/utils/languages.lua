local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')
local jdtls_workspace_dir = vim.fn.expand('~/.cache/jdtls/workspace') .. '/'

vim.lsp.log.set_level(vim.log.levels.INFO)
local languages = {
  lua_ls = {
    on_init = function(client)
      if client.workspace_folders then
        local path = client.workspace_folders[1].name
        if path ~= vim.fn.stdpath('config') and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then
          return
        end
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
        runtime = {
          -- Tell the language server which version of Lua you're using (most
          -- likely LuaJIT in the case of Neovim)
          version = 'LuaJIT',
          -- Tell the language server how to find Lua modules same way as Neovim
          -- (see `:h lua-module-load`)
          path = {
            'lua/?.lua',
            'lua/?/init.lua',
          },
        },
        -- Make the server aware of Neovim runtime files
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME
            -- Depending on the usage, you might want to add additional paths
            -- here.
            -- '${3rd}/luv/library'
            -- '${3rd}/busted/library'
          }
          -- Or pull in all of 'runtimepath'.
          -- NOTE: this is a lot slower and will cause issues when working on
          -- your own configuration.
          -- See https://github.com/neovim/nvim-lspconfig/issues/3189
          -- library = {
          --   vim.api.nvim_get_runtime_file('', true),
          -- }
        }
      })
    end,
    settings = {
      Lua = {}
    }
  },
  denols = {
    root_dir = function(_, on_dir)
      local root_file = vim.fs.root(0, 'deno.json')
      if root_file ~= nil then
        on_dir(vim.fs.root(0, 'deno.json'))
      end
    end
  },
  jsonls = {
    settings = {
      json = {
        validate = { enable = true },
        schemas = {
          {
            description = "NPM configuration file",
            fileMatch = { "package.json" },
            name = "package.json",
            url = "https://www.schemastore.org/package.json"
          },
          {
            description = "TypeScript compiler configuration file",
            fileMatch = { "tsconfig*.json" },
            name = "tsconfig.json",
            url = "https://www.schemastore.org/tsconfig.json"
          }
        }
      }
    }
  },
  ts_ls = {
    root_dir = function(_, on_dir)
      local root_file = vim.fs.root(0, 'deno.json')
      if root_file == nil then
        on_dir()
      end
    end,

    settings = {
      typescript = {
        inlayHints = {
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },
  neocmake = {
    capabilities = vim.tbl_extend('force', vim.lsp.protocol.make_client_capabilities(),
      {
        textDocument = { completion = { completionItem = { snippetSupport = true } } }
      }
    ),
    cmd = { 'neocmakelsp', 'stdio' },
    filetypes = { 'cmake' },
    root_markers = { ".git", "build", "cmake" },
  },
  jdtls = {
    cmd = {
      'jdtls', '-data', jdtls_workspace_dir .. project_name
    },
    settings = {
      java = {
      }
    }
  }
}



local capabilities = require('cmp_nvim_lsp').default_capabilities()


capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}


vim.lsp.config('*', {
  capabilities = capabilities
})


for language, opts in pairs(languages) do
  vim.lsp.config(language, opts)
  vim.lsp.enable(language)
end
