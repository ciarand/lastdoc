local lpeg    = require "lpeg"

local P, R, S, V, C, Cg, Cb, Cmt, Cc, Cf, Ct, B, Cs =
  lpeg.P, lpeg.R, lpeg.S, lpeg.V, lpeg.C, lpeg.Cg, lpeg.Cb,
  lpeg.Cmt, lpeg.Cc, lpeg.Cf, lpeg.Ct, lpeg.B, lpeg.Cs

local exports = {}

local any            = P(1)
local fail           = any - 1
local always         = P("")
local eof            = - any

local spacechar      = P("\t ")
local newline        = P("\n")
local hash           = P("#")
local equal          = P("=")
local dash           = P("-")


local optionalspace  = spacechar^0
local spaces         = spacechar^1
local linechar       = P(1 - newline)

local blankline      = optionalspace * newline / "\n"
local blanklines     = blankline^0
local line           = linechar^0 * newline + linechar^1 * eof
local nonemptyline   = line - blankline

exports.headerNode = function(str, level)
    if level == nil then l = 1
    elseif level > 6 then l = 6
    else l = level end

    return { title = str, level = l }
end

exports.parseHeaderNode = function(str)
    local HeadingLevel = equal^1 * Cc(1) + dash^1 * Cc(2)

    local rules = #(line * equal)
                * C(line - newline)
                * HeadingLevel
                * optionalspace * newline^0
                / function(s, l) return { title = s:gsub("(.-)%s*$", "%1"), level = l } end

    local res = lpeg.match(rules, str)
    if res ~= nil then
        return res
    end

    error(string.format("parse_blocks failed on:\n%s", str:sub(1,20)))
end

return exports
