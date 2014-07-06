local lpeg    = require "lpeg"

local P, R, S, V, C, Cg, Cb, Cmt, Cc, Cf, Ct, B, Cs =
  lpeg.P, lpeg.R, lpeg.S, lpeg.V, lpeg.C, lpeg.Cg, lpeg.Cb,
  lpeg.Cmt, lpeg.Cc, lpeg.Cf, lpeg.Ct, lpeg.B, lpeg.Cs

local exports = {}

-- part groups
local eol   = P("\n")
local equal = P("=")
local dash  = P("-")

-- capture groups
-- capture a string up until any number of eols
local line    = C((1 - eol) ^1)

exports.headerNode = function(str)
    return { title = str }
end

exports.parseHeaderNode = function(str)
    local header = lpeg.match(line, str)
    local hlen = string.len(header)

    return { title = header }
end

return exports
