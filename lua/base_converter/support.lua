local M = {}

M.table_invert = function(t)
  local s = {}
  for k, v in ipairs(t) do
    s[vim.inspect(v)] = k
  end
  return s
end

M.get_bounds = function()
  table.unpack = table.unpack or unpack -- 5.1 compatibility
  -- get the selection area
  local y1, x1 = table.unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local y2, x2 = table.unpack(vim.api.nvim_buf_get_mark(0, ">"))
  if y1 > y2 then
    y2, y1 = y1, y2
  end
  if x1 > x2 then
    x2, x1 = x1, x2
  end
  return y1, x1, y2, x2
end

M.build_visual_selection = function(y1, y2, x1, x2)
  local mode = vim.fn.visualmode()
  local visual_selection = {}
  local index = 1
  for i = y1 - 1, y2 - 1, 1 do
    local line_segment
    if mode == "V" then
      line_segment = vim.api.nvim_buf_get_lines(0, i, i + 1, false)
    elseif mode == "" then
      line_segment = vim.api.nvim_buf_get_text(0, i, x1, i, x2 + 1, {})[1]
    elseif mode == "v" then
      if i == y1 - 1 then
        local full_line_segment = vim.api.nvim_buf_get_lines(0, i, i + 1, false)
        line_segment = string.sub(full_line_segment[1], x1+1)
      elseif i == y2 - 1 then
        local full_line_segment = vim.api.nvim_buf_get_lines(0, i, i + 1, false)
        line_segment = string.sub(full_line_segment[1], 1, x1+2)
      else
        line_segment = vim.api.nvim_buf_get_lines(0, i, i + 1, false)[1]
      end
    end
    visual_selection[index] = {
      index + y1 - 1,
      line_segment,
    }
    index = index + 1
  end
  return visual_selection
end

M.sort_visual_selection = function(visual_selection, descending)
  table.sort(visual_selection, function(a, b)
    if b[2] == "" then
      print(vim.inspect(a), vim.inspect(b))
      return a[1] < b[1]
    end
    if descending == "rev" then
      return a[2] > b[2]
    else
      return a[2] < b[2]
    end
  end)
end

M.get_lines = function(y1)
  local function wrapper(k, item)
    local original_line = vim.api.nvim_buf_get_lines(0, y1 - 2 + k, y1 - 1 + k, false)
    local target_line = vim.api.nvim_buf_get_lines(0, item[1] - 1, item[1], false)
    return original_line, target_line
  end
  return wrapper
end

M.string_from_hex = function(arg)
  local hex_string
  local chunk_size = 2
  local s = {}

  -- make sure hex hase even number of digits
  if math.fmod(#arg, 2) == 1 then
    hex_string = "0" .. arg
  else
    hex_string = arg
  end

  for i = 1, #hex_string, chunk_size do
    s[#s + 1] = string.char(tonumber(string.sub(hex_string, i, i + chunk_size - 1), 16))
  end

  return table.concat(s, "")
end

M.string_to_hex = function(arg)
  local s = {}
  local char
  for i = 1, #arg do
    char = string.sub(arg, i, i)
    table.insert(s, string.format("%02x", string.byte(char)))
  end
  return table.concat(s, "")
end

return M
