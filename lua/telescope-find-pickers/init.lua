local builtin_pickers = require("telescope.builtin")
local extensions_pickers = require("telescope._extensions")

local result_table = {}
-- vim.notify("hahahhah")
-- print("hahahahahhahaha")
local opts_pickers = {
  bufnr = vim.api.nvim_get_current_buf(),
  winnr = vim.api.nvim_get_current_win(),
}

-- Variables that setup can change

local excluded = extensions_pickers._config.find_pickers.excluded or {}
local plugin_opts = extensions_pickers._config.find_pickers.opts or {}
local funcs = extensions_pickers._config.find_pickers.actions or {}
-- print(vim.inspect(funcs))

for name, item in pairs(builtin_pickers) do
  if not (vim.tbl_contains(excluded, name)) then
    result_table[name] = {
      action = funcs[name] or item or function() end,
      opt = plugin_opts[name] or opts_pickers,
    }
  end
end

for name, item in pairs(extensions_pickers.manager) do
  if not (vim.tbl_contains(excluded, name)) then
    result_table[name] = {
      action = funcs[name] or item[name] or function() end,
      opt = plugin_opts[name] or opts_pickers,
    }
  end
end

return { results = result_table }
