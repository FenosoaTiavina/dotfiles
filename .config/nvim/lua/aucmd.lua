local function run_build(spec, path)

    local build = spec.data and spec.data.build

    if not build then return end

    vim.system({ "sh", "-c", build }, {
        cwd = path,
        text = true,
    })
end

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.kind == "install" or ev.data.kind == "update" then
            run_build(ev.data.spec, ev.data.path)
        end
    end,
})

for _, plug in ipairs(vim.pack.get()) do
    local spec = plug.spec

    if spec.data and spec.data.event then
        vim.api.nvim_create_autocmd(spec.data.event, {
            once = true,
            callback = function()
                vim.cmd("packadd " .. spec.name)
            end,
        })
    end
end
