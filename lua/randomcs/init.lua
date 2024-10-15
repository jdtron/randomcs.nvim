local M = {
    config = {},
    _schemes = {},
}

---Setup randomcs
---@param cfg table|nil
---@param schemes table|nil
M.setup = function(cfg, schemes)
    cfg = cfg or {}
    M.config = M.default_config(cfg)
    if not M.config.enabled then
        if M.config.default then
            vim.cmd.colorscheme(M.config.default)
        end
        return
    end

    for _, scheme_name in ipairs(schemes or {}) do
        M.register(scheme_name)
    end

    local scheme = M.random_scheme()
    if not scheme then
        return
    end

    vim.cmd.colorscheme(scheme)
    if M.config.notify then
        local timer = vim.uv.new_timer()
        timer:start(500, 0, vim.schedule_wrap(function()
            vim.notify("Random " .. M.config.mode .. " colorscheme: " .. scheme)
        end))
    end
end

---Check config and insert sane defaults
---@param config table
M.default_config = function(config)
    config = config or {}
    config.mode = "daily"
    if config.enabled == nil then
        config.enabled = true
    end
    if config.notify == nil then
        config.notify = true
    end

    return config
end

---Register a scheme with randomcs
---@param scheme_name string: Name of the scheme to register
M.register = function(scheme_name)
    for _, scheme in ipairs(M._schemes) do
        if scheme == scheme_name then
            return
        end
    end

    table.insert(M._schemes, scheme_name)
end

---Pick a random scheme based on the configured mode
---@return string|nil
M.random_scheme = function()
    local mode = M.config.mode
    local date = os.date("*t")
    local idx = nil

    if mode == "daily" then
        idx = date.yday % #M._schemes + 1
    elseif mode == "weekly" then
        idx = math.floor(date.yday / 7) % #M._schemes + 1
    elseif mode == "monthly" then
        idx = date.month % #M._schemes
    end

    return M._schemes[idx]
end

return M
