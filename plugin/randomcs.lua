vim.api.nvim_create_user_command("Randomcs", function ()
    require("randomcs").apply()
end, { nargs = 0 })

vim.api.nvim_create_user_command("RandomcsDefault", function ()
    require("randomcs").apply_default()
end, { nargs = 0 })
