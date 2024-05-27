local function isarray(x)
  return type(x) == "table" and x[1] ~= nil
end

local getiter = function(x)
  if isarray(x) then
    return ipairs
  elseif type(x) == "table" then
    return pairs
  end
  error("expected table", 3)
end


-- Returns a new table with all the given tables merged together. If a key exists in multiple tables the right-most table's value is used.
-- https://github.com/rxi/lume/blob/98847e7812cf28d3d64b289b03fad71dc704547d/lume.lua#L348C1-L358C4
local function merge_tables(...)
  local rtn = {}
  for i = 1, select("#", ...) do
    local t = select(i, ...)
    local iter = getiter(t)
    for k, v in iter(t) do
      rtn[k] = v
    end
  end
  return rtn
end

local function options(opts)
  if opts == nil then opts = {} end
  return merge_tables({ noremap = true, silent = true }, opts)
end

return {
  nmap = function(mapTo, mapFrom, opts)
    vim.keymap.set('n', mapTo, mapFrom, options(opts))
  end,

  nvmap = function(mapTo, mapFrom, opts)
    vim.keymap.set({ 'n', 'v' }, mapTo, mapFrom, options(opts))
  end,

  imap = function(mapTo, mapFrom, opts)
    vim.keymap.set('i', mapTo, mapFrom, options(opts))
  end,

  map = function(mapTo, mapFrom, opts)
    vim.keymap.set('', mapTo, mapFrom, options(opts))
  end,
}
