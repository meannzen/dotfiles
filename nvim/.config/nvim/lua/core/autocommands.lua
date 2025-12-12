vim.api.nvim_create_autocmd('Filetype', { pattern = 'rust', command = 'set colorcolumn=100' })

vim.api.nvim_create_autocmd(
	'TextYankPost',
	{
		pattern = '*',
		command = 'silent! lua vim.highlight.on_yank({ timeout = 500 })'
	}
)

vim.api.nvim_create_autocmd(
	'BufReadPost',
	{
		pattern = '*',
		callback = function(ev)
			if vim.fn.line("'\"") > 1 and vim.fn.line("'\"") <= vim.fn.line("$") then
				if not vim.fn.expand('%:p'):find('.git', 1, true) then
					vim.cmd('exe "normal! g\'"')
				end
			end
		end
	}
)

vim.api.nvim_create_autocmd('BufRead', { pattern = '*.orig', command = 'set readonly' })
vim.api.nvim_create_autocmd('BufRead', { pattern = '*.pacnew', command = 'set readonly' })
vim.api.nvim_create_autocmd('InsertLeave', { pattern = '*', command = 'set nopaste' })

local email = vim.api.nvim_create_augroup('email', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
	pattern = '/tmp/mutt*',
	group = email,
	command = 'setfiletype mail',
})

vim.api.nvim_create_autocmd('Filetype', {
	pattern = 'mail',
	group = email,
	command = 'setlocal formatoptions+=w',
})

local text = vim.api.nvim_create_augroup('text', { clear = true })
for _, pat in ipairs({'text', 'markdown', 'mail', 'gitcommit'}) do
	vim.api.nvim_create_autocmd('Filetype', {
		pattern = pat,
		group = text,
		command = 'setlocal spell tw=72 colorcolumn=73',
	})
end

vim.api.nvim_create_autocmd('Filetype', {
	pattern = 'tex',
	group = text,
	command = 'setlocal spell tw=80 colorcolumn=81',
})

