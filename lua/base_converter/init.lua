local config = require("base_converter.config")
local support = require("base_converter.support")

M = {}

-- M.setup = config.setup
--
-- M.sort_visual_block = function(descending)
--   local mode = vim.fn.visualmode()
--   if mode == "" then
--     local y1, x1, y2, x2 = support.get_bounds()
--     -- build the (line, string) array
--     local visual_selection = support.build_visual_selection(y1, y2, x1, x2)
--     --sort the (line, string array)
--     support.sort_visual_selection(visual_selection, descending)
--     -- partial functions for cleaner look
--     local get_lines = support.get_lines(y1)
--
--     -- visual_selection is now sorted
--     local seen = {}
--
--     for k, item in ipairs(visual_selection) do
--       local orig, targ = get_lines(k, item)
--       if seen[item[1]] then
--         vim.api.nvim_buf_set_lines(0, y1 - 2 + k, y1 - 1 + k, false, seen[item[1]])
--       else
--         vim.api.nvim_buf_set_lines(0, y1 - 2 + k, y1 - 1 + k, false, targ)
--         seen[k + y1 - 1] = orig
--       end
--     end
--   end
-- end

return M
