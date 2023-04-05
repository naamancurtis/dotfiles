local M = {}

M.imap = function(tbl, desc)
  if tbl[3] == nil then
    tbl[3] = {}
  end
  tbl[3].desc = desc
  vim.keymap.set("i", tbl[1], tbl[2], tbl[3])
end

M.nmap = function(tbl, desc)
  if tbl[3] == nil then
    tbl[3] = {}
  end
  tbl[3].desc = desc
  vim.keymap.set("n", tbl[1], tbl[2], tbl[3])
end

M.autocmd = function(args)
  local event = args[1]
  local group = args[2]
  local callback = args[3]

  vim.api.nvim_create_autocmd(event, {
    group = group,
    buffer = args[4],
    callback = function()
      callback()
    end,
    once = args.once,
  })
end

return M
