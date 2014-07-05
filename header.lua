local lpeg    = require "lpeg"

local p = lpeg.P
local c = lpeg.C

local parts   = {}
local exports = {}

-- part groups
parts.eol     = p("\n")
parts.equals  = p("=")

-- capture groups
-- capture a string up until any number of eols
parts.line    = c((1 - parts.eol) ^1)

exports.headerNode = function(str)
    return { title = str }
end

exports.parseHeaderNode = function(str)
    local header = lpeg.match(parts.line, str)
    local hlen = string.len(header)

    return { title = header }
end

return exports
