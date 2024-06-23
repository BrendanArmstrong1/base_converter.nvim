local config = require("base_converter.config")
local support = require("base_converter.support")

M = {}

M.setup = config.setup

M.convert = function(from, to)
  local mode = vim.fn.visualmode()
  if mode == "V" then
    local y1, x1, y2, x2 = support.get_bounds()
    local visual_selection = support.build_visual_selection(y1, y2, x1, x2)
    for _, v in pairs(visual_selection) do
      local line = v[1]
      local hex_line = { support.string_to_hex(v[2][1]) }
      vim.api.nvim_buf_set_lines(0, line - 1, line, false, hex_line)
    end
  elseif mode == "v" then
    local y1, x1, y2, x2 = support.get_bounds()
    local height_of_visual = y2 - y1 + 1
    local visual_selection = support.build_visual_selection(y1, y2, x1, x2)
    for k, v in ipairs(visual_selection) do
      local line = v[1] - 1
      local hex_line = {support.string_to_hex(v[2])}
      print(k)
      if k == 1 then
        vim.api.nvim_buf_set_text(0, line, x1, line, -1, hex_line)
      elseif k == height_of_visual then
        vim.api.nvim_buf_set_text(0, line, 1, line, x2, hex_line)
      else
        vim.api.nvim_buf_set_lines(0, line , line+1, false, hex_line)
      end
    end
  elseif mode == "" then
    local y1, x1, y2, x2 = support.get_bounds()
    local visual_selection = support.build_visual_selection(y1, y2, x1, x2)
    vim.print(visual_selection)
    for _, v in pairs(visual_selection) do
      local line = v[1] - 1
      local hex_line = { support.string_to_hex(v[2]) }
      vim.api.nvim_buf_set_text(0, line, x1, line, x2 + 1, hex_line)
    end
  end
end

return M
