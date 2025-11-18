return {
  "akinsho/toggleterm.nvim",

  config = function()
    local toggleterm = require("toggleterm")
    local Terminal = require("toggleterm.terminal").Terminal

    toggleterm.setup {
      size = 20,
      open_mapping = [[<C-\>]],
      direction = "float",
      start_in_insert = true,
      persist_mode = false,  -- Desactivar persist_mode
      close_on_exit = true,
      -- otras opciones...
    }

    function goto_next_term()
      local cur = vim.b.toggle_number or 0
      local nxt = cur + 1
      if nxt > 3 then
        nxt = 1
      end
      vim.cmd(string.format("%dToggleTerm", nxt))
    end

    function goto_prev_term()
      local cur = vim.b.toggle_number or 0
      local prv = cur - 1
      if prv < 1 then
        prv = 3
      end
      vim.cmd(string.format("%dToggleTerm", prv))
    end

    function _G.set_terminal_keymaps()
      local opts = { noremap = true, silent = true }
      -- salida del modo terminal
      vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)

      -- navegación entre splits
      vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)

      -- **nuevos atajos Ctrl+Shift+j / Ctrl+Shift+k** en modo terminal
      -- nota: la forma de escribir Ctrl+Shift puede depender del terminal / Neovim
      vim.api.nvim_set_keymap('n', '<C-A-j>', [[<Cmd>lua goto_next_term()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<C-A-j>', [[<Cmd>lua goto_next_term()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<C-A-k>', [[<Cmd>lua goto_prev_term()<CR>]], { noremap = true, silent = true })
      vim.api.nvim_set_keymap('t', '<C-A-k>', [[<Cmd>lua goto_prev_term()<CR>]], { noremap = true, silent = true })


    end

    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}

