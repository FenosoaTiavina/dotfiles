-- Pure Lua Tree-sitter installer (Neovim 0.10+ | CLI 0.24+)
-- took from: https://github.com/nvim-treesitter/nvim-treesitter/blob/main/lua/nvim-treesitter/parsers.lua
local ABI_VERSION = "latest" -- Change to "15" or "latest" if your Neovim uses tree-sitter >= 0.24

local PARSER_CONFIGS = {
    -- Example: Multi-parser repo with explicit paths
    typescript = {
        repo = "https://github.com/tree-sitter/tree-sitter-typescript.git",
        ref = nil, -- nil = default branch, or use "v0.21.1", "main", or commit hash
        parsers = {
            { name = "typescript", grammar = "typescript/src/grammar.json", build_dir = "typescript" },
            { name = "tsx",        grammar = "tsx/src/grammar.json",        build_dir = "tsx" }
        }
    },

    markdown = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-markdown.git",
        ref = nil,
        parsers = {
            { name = "markdown",        grammar = "tree-sitter-markdown/src/grammar.json",        build_dir = "tree-sitter-markdown/" },
            { name = "markdown_inline", grammar = "tree-sitter-markdown-inline/src/grammar.json", build_dir = "tree-sitter-markdown-inline/" },
        },
    },

    cpp = {
        repo = "https://github.com/tree-sitter/tree-sitter-cpp.git",
        ref = nil,
        parsers = {
            { name = "cpp", grammar = "src/grammar.json", build_dir = "./" },
        },
    },

    -- Example: Custom repo with pinned branch
    fish = {
        repo = "https://github.com/ram02z/tree-sitter-fish.git",
        ref = "main",
    },

    -- Example: Simple custom repo (defaults to single parser)
    dockerfile = {
        repo = "https://github.com/camdencheek/tree-sitter-dockerfile.git",
        ref = nil,
    },

    cmake = {
        repo = "https://github.com/uyha/tree-sitter-cmake",
    },

    csv = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-csv",
        parsers = {
            { name = "csv", grammar = "csv/src/grammar.json", build_dir = "csv" },
            { name = "tsv", grammar = "tsv/src/grammar.json", build_dir = "tsv" },
            { name = "psv", grammar = "psv/src/grammar.json", build_dir = "psv" },
        },
    },

    diff = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-diff",
    },

    editorconfig = {
        repo = "https://github.com/ValdezFOmar/tree-sitter-editorconfig",
    },

    git_config = {
        repo = "https://github.com/the-mikedavis/tree-sitter-git-config",
    },

    git_rebase = {
        repo = "https://github.com/the-mikedavis/tree-sitter-git-rebase",
    },

    gitattributes = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-gitattributes",
    },

    gitcommit = {
        repo = "https://github.com/gbprod/tree-sitter-gitcommit.git",
    },

    gitignore = {
        repo = "https://github.com/shunsambongi/tree-sitter-gitignore.git",
    },

    gomod = {
        repo = "https://github.com/camdencheek/tree-sitter-go-mod.git",
    },
    gosum = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-go-sum.git",
    },
    gotmpl = {
        repo = "https://github.com/ngalaiko/tree-sitter-go-template.git",
    },
    gowork = {
        repo = "https://github.com/omertuc/tree-sitter-go-work.git",
    },

    helm = {
        repo = "https://github.com/ngalaiko/tree-sitter-go-template",
        parsers = { { name = "helm", grammar = "dialects/helm/src/grammar.json", build_dir = "dialects/helm" } },
    },
    gpg = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-gpg-config.git",
    },
    htmldjango = {
        repo = "https://github.com/interdependence/tree-sitter-htmldjango.git",
    },
    http = {
        repo = "https://github.com/rest-nvim/tree-sitter-http.git",
    },
    javadoc = {
        repo = "https://github.com/rmuir/tree-sitter-javadoc.git",
    },

    jinja = {
        repo = "https://github.com/cathaysia/tree-sitter-jinja.git",
        parsers = {
            { name = "jinja",        grammar = "tree-sitter-jinja/src/grammar.json",        build_dir = "tree-sitter-jinja" },
            { name = "jinja_inline", grammar = "tree-sitter-jinja_inline/src/grammar.json", build_dir = "tree-sitter-jinja_inline" },
        },
    },

    jq = {
        repo = "https://github.com/flurie/tree-sitter-jq.git",
    },
    json5 = {
        repo = "https://github.com/Joakker/tree-sitter-json5.git",
    },
    latex = {
        repo = "https://github.com/latex-lsp/tree-sitter-latex.git",
    },
    lua = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-lua.git",
    },
    luadoc = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-luadoc.git",
    },
    make = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-make.git",
    },
    matlab = {
        repo = "https://github.com/acristoffers/tree-sitter-matlab.git",
    },
    nginx = {
        repo = "https://github.com/opa-oz/tree-sitter-nginx.git",
    },
    proto = {
        repo = "https://github.com/coder3101/tree-sitter-proto.git",
    },

    ssh_config = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-ssh-config.git",
    },
    tmux = {
        repo = "https://github.com/Freed-Wu/tree-sitter-tmux.git",
    },
    toml = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-toml.git",
    },
    vim = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-vim.git",
    },
    vimdoc = {
        repo = "https://github.com/neovim/tree-sitter-vimdoc.git",
    },
    xml = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-xml.git",
        parsers = {
            { name = "xml", grammar = "xml/src/grammar.json", build_dir = "xml" },
            { name = "dtd", grammar = "dtd/src/grammar.json", build_dir = "dtd" },
        },
    },
    zsh = {
        repo = "https://github.com/georgeharker/tree-sitter-zsh.git",
    },
    vue = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-vue.git",
        parsers = {
            { name = "vue", grammar = "src/grammar.json", build_dir = "./" },
        },
    },

    yaml = {
        repo = "https://github.com/tree-sitter-grammars/tree-sitter-yaml",
        ref = nil,
    },

    hyprlang = {}
}

local LOG_FILE = vim.fn.stdpath("data") .. "/ts-install.log"

local function log_to_file(msg)
    print(msg)

    local f = io.open(LOG_FILE, "a")
    if f then
        f:write(msg .. "\n")
        f:close()
    end
end


local function install_parser(lang)
    -- Resolve config or create default fallback
    local cfg = PARSER_CONFIGS[lang] or { repo = "https://github.com/tree-sitter/tree-sitter-" .. lang .. ".git" }
    if not cfg.parsers then cfg.parsers = { { name = lang } } end

    local ext = vim.fn.has("win32") == 1 and ".dll"
        or (vim.fn.has("mac") == 1 and ".dylib" or ".so")
    local base_dir = vim.fn.stdpath("data") .. "/tree-sitter"
    local parser_dir = base_dir .. "/parser"
    vim.fn.mkdir(parser_dir, "p")

    -- Add to runtimepath for current session
    local rtp = vim.opt.rtp:get()
    if not vim.tbl_contains(rtp, base_dir) then
        vim.opt.rtp:append(base_dir)
    end

    local tmp_dir = vim.fn.tempname() .. "_ts_" .. lang
    local success = true

    -- 1. Clone repository
    log_to_file(("Cloning %s ..."):format(cfg.repo))
    local clone = vim.system({ "git", "clone", cfg.repo, tmp_dir }):wait()
    if clone.code ~= 0 then
        vim.fn.delete(tmp_dir, "rf")
        log_to_file("Clone failed. Check URL and network.")
        return
    end

    -- 2. Checkout specific ref if provided
    if cfg.ref then
        log_to_file(("Checking out ref: %s"):format(cfg.ref))
        local checkout = vim.system({ "git", "-C", tmp_dir, "checkout", cfg.ref }):wait()
        if checkout.code ~= 0 then
            vim.fn.delete(tmp_dir, "rf")
            log_to_file(("Checkout failed for ref: %s"):format(cfg.ref))
            return
        end
    end

    -- 3. Generate & Build each parser
    for _, p in ipairs(cfg.parsers) do
        local parser_name = p.name
        local grammar_path = p.grammar
        local build_dir = p.build_dir or "."
        local output_path = parser_dir .. "/" .. parser_name .. ext

        -- Skip if already exists
        if vim.uv.fs_stat(output_path) then
            log_to_file(("Skipping %s: already installed."):format(parser_name))
            -- vim.treesitter.language.register({ parser_name }, parser_name)
            goto continue
        end

        -- Generate C source
        log_to_file(("Generating %s ..."):format(parser_name))
        local gen_cmd = { "tree-sitter", "generate", "--abi", ABI_VERSION }
        if grammar_path then table.insert(gen_cmd, grammar_path) end
        local gen = vim.system(gen_cmd, { cwd = tmp_dir }):wait()
        if gen.code ~= 0 then
            log_to_file(("Generation failed for %s. Grammar may require ABI > %s"):format(parser_name, ABI_VERSION))
            success = false
            break
        end

        -- Compile shared library
        log_to_file(("Building %s ..."):format(parser_name))
        local build_cmd = { "tree-sitter", "build", "-o", output_path, build_dir }
        local build = vim.system(build_cmd, { cwd = tmp_dir }):wait()
        if build.code ~= 0 then
            log_to_file(("Build failed for %s. Ensure C compiler & tree-sitter CLI are in PATH."):format(parser_name))
            success = false
            break
        end

        log_to_file(("Successfully installed %s."):format(parser_name))
        -- vim.treesitter.language.register({ parser_name }, parser_name)

        ::continue::
    end

    -- Add this to install_parser() after successful build:
    local queries_dir = tmp_dir .. "/queries"
    log_to_file(("Check if parser has queries: %s"):format(queries_dir))
    if vim.uv.fs_stat(queries_dir) then
        local target_queries = base_dir .. "/queries/" .. lang
        vim.fn.mkdir(target_queries, "p")
        vim.fn.system("cp -r " .. queries_dir .. "/* " .. target_queries .. "/")
        log_to_file(("Installed queries for %s"):format(lang))
    end

    -- 4. Cleanup
    vim.fn.delete(tmp_dir, "rf")
    if not success then
        log_to_file("Installation aborted due to errors.")
    end
end

vim.api.nvim_create_user_command("TSInstall", function(opts)
    local lang = opts.args:match("^%s*(%S+)%s*$")
    if not lang then
        print("Usage: :TSInstall <language>")
        return
    end
    install_parser(lang)
end, { nargs = 1 })
