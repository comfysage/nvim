return {
  mappings = {
    show_lsp_info = '<space>si',
  },
  signature = {
    enabled = true,
    window = {
      height = 20,
      width = 64,
      border = 'none',
    },
  },
  diagnostic_lines = {
    enabled = true,
    severity = vim.diagnostic.severity.WARN,
  },
  servers = {
    denols = function(nvim_lsp)
      return {
        filetypes = { 'typescript', 'typescriptreact', 'typescript.tsx' },
        root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", "main.ts"),
      }
    end,
    gopls = {},
    svelte = {},
    rust_analyzer = {},
    clangd = {},
    tailwindcss = {
      filetypes = { 'aspnetcorerazor', 'astro', 'astro-markdown', 'blade', 'clojure', 'django-html', 'htmldjango', 'edge', 'eelixir', 'elixir', 'ejs', 'erb', 'eruby', 'gohtml', 'gohtmltmpl', 'haml', 'handlebars', 'hbs', 'html', 'html-eex', 'heex', 'jade', 'leaf', 'liquid', 'mdx', 'mustache', 'njk', 'nunjucks', 'php', 'razor', 'slim', 'twig', 'sugarss', 'javascript', 'javascriptreact', 'reason', 'rescript', 'typescript', 'typescriptreact', 'vue', 'svelte' }
    },
    rnix = {},
    tsserver = function(nvim_lsp)
      return {
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact",
          "javascript.jsx" },
        root_dir = nvim_lsp.util.root_pattern("package.json"),
        single_file_support = false,
      }
    end,
    zk = {
      filetypes = { 'markdown' },
      settings = {}
    },
    lua_ls = {},
  },
}
