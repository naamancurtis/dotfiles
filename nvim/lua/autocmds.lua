local au = require('au')

-- # Simple autocmd with one event: au.<event> = string | fn | { pattern: string, action: string | fn }

-- 1. If you want aucmd to fire on every buffer, you can use the style below
au.TextYankPost = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 250 })
end

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.rs,*.lua,*.sh,*.json,*.py,*.tf FormatWrite
augroup END
]], true)

vim.api.nvim_exec([[
augroup EnvrcFileType
  autocmd!
  autocmd BufNewFile,BufRead *.envrc set filetype=sh
augroup END
]], true)
