if not pcall(require, "telescope") then
  return
end

TelescopeMapArgs = TelescopeMapArgs or {}

local map_tele = function(key, f, desc, options, buffer)
  local map_key = vim.api.nvim_replace_termcodes(key .. f, true, true, true)

  TelescopeMapArgs[map_key] = options or {}
  print(options)

  local mode = "n"
  local rhs = string.format("<cmd>lua R('nj.telescope')['%s'](TelescopeMapArgs['%s'])<CR>", f, map_key)

  local map_options = {
    noremap = true,
    silent = true,
    desc = desc
  }

  if not buffer then
    vim.api.nvim_set_keymap(mode, key, rhs, map_options)
  else
    vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_options)
  end
end

vim.api.nvim_set_keymap("c", "<c-r><c-r>", "<Plug>(TelescopeFuzzyCommandSearch)", { noremap = false, nowait = true, desc = "Telescope Fuzzy Command Search" })

return map_tele
