M = {}

local parse_format = function(arg)
  local base
  if arg == "none" then
    base = "pass"
  elseif arg == "h" or arg == "hex" then
    base = "hex"
  elseif arg == "d" or arg == "decimal" or arg == "dec" then
    base = "dec"
  elseif arg == "c" or arg == "o" or arg == "oct" then
    base = "oct"
  elseif arg == "b" or arg == "binary" or arg == "bin" then
    base = "bin"
  elseif arg == "s" or arg == "string" or arg == "str" then
    base = "str"
  end
  return base
end

function M.setup()
  vim.api.nvim_create_user_command("BConvert", function(args)
    local from_raw = string.match(args.fargs[1], '^.*"(.-)".*$')
    local to_raw = string.match(args.fargs[2], '^.*"(.-)".*$')
    local from = parse_format(from_raw)
    local to = parse_format(to_raw)
    require("base_converter").convert(from, to)
  end, { range = true, nargs = "*" })
end
return M
