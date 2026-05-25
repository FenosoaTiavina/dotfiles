function tprint(tbl, indent)
    if not indent then indent = 0 end
    local toprint = string.rep(" ", indent) .. "{\r\n"
    indent = indent + 2
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent)
        if (type(k) == "number") then
            toprint = toprint .. "[" .. k .. "] = "
        elseif (type(k) == "string") then
            toprint = toprint .. k .. "= "
        end
        if (type(v) == "number") then
            toprint = toprint .. v .. ",\r\n"
        elseif (type(v) == "string") then
            toprint = toprint .. "\"" .. v .. "\",\r\n"
        elseif (type(v) == "table") then
            toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
        else
            toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
        end
    end
    toprint = toprint .. string.rep(" ", indent - 2) .. "}"
    return toprint
end

local function run_build(data, path)
    local build = data.spec.data and data.spec.data.build
    local cmd = data.spec.data and data.spec.data.cmd
    local hook = data.spec.data and data.spec.data.hook

    if not build and not cmd then return end
    if build then
        vim.system({ "sh", "-c", build }, {
            cwd = path,
            text = true,
        })
    end

    if cmd then
        vim.cmd(cmd)
    end

    if hook and type(hook) == "function" then
        hook(data)
    end
end

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.kind == "install" or ev.data.kind == "update" then
            run_build(ev.data, ev.data.path)
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
