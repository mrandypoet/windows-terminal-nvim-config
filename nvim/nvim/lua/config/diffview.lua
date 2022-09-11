local nmap = require('utils').nmap

require('diffview').setup()

nmap('<leader>fh', '<cmd>DiffviewFileHistory %<cr>')
nmap('<leader>cd', '<cmd>DiffviewClose<cr>')


