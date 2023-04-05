local M = {}

M.run = function()
  if vim.o.modified then
    vim.cmd [[w]]
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local line = vim.api.nvim_win_get_cursor(0)[1]

  local lenses = vim.deepcopy(vim.lsp.codelens.get(bufnr))

  lenses = vim.tbl_filter(function(v)
    return v.range.start.line < line
  end, lenses)

  table.sort(lenses, function(a, b)
    return a.range.start.line < b.range.start.line
  end)

  local _, lens = next(lenses)

  local client_id = next(vim.lsp.buf_get_clients(bufnr))
  local client = vim.lsp.get_client_by_id(client_id)
  client.request("workspace/executeCommand", lens.command, function(...)
    local result = vim.lsp.handlers["workspace/executeCommand"](...)
    vim.lsp.codelens.refresh()
    return result
  end, bufnr)
end

local virtlines_enabled = true
M.toggle_virtlines = function()
  virtlines_enabled = not virtlines_enabled
  M.refresh_virtlines()
end

M.refresh_virtlines = function()
  local params = { textDocument = vim.lsp.util.make_text_document_params() }
  vim.lsp.buf_request(0, "textDocument/codeLens", params, function(err, result, ctx, _)
    if err then
      return
    end

    local ns = vim.api.nvim_create_namespace "custom-lsp-codelens"
    vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

    if not virtlines_enabled then
      return
    end

    for _, lens in ipairs(result) do
      local title = lens.command.title
      local range = lens.range
      local text = string.rep(" ", lens.range.start.character) .. title

      vim.api.nvim_buf_set_extmark(0, ns, range.start.line - 1, 0, {
        virt_lines = {
          { { text, "VirtNonText" } },
        },
      })
    end
  end)
end

return M
