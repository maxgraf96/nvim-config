local copilot_config = function()
  local M = {}

  M.suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 25,
    keymap = {
      accept = '<TAB>',
      accept_word = '<C-j>',
      dismiss = '<C-d>',
      next = '<C-i>',
      prev = '<C-o>',
    },
  }
  M.filetypes = {
    yaml = true,
    lua = true,
  }
  M.panel = { enabled = true }
  require('copilot').setup(M)
end

return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    lazy = true,
    config = copilot_config,
  },
}
