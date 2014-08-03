local split = function(s, sep)
    local exp = {}
    local i = 1
    local cur = 0
    local pos = nil

    while true do
        pos = string.find(s, sep, cur)
        if pos == nil then
            break
        end

        exp[i] = s:sub(cur, pos - 1)

        cur = pos + 1
        i = 1 + i
    end

    -- we also need to get the last part
    exp[i] = s:sub(cur)

    return exp
end

local trim = function(s)
    return s:match'^()%s*$' and '' or s:match'^%s*(.*%S)'
end

return {
    split = split,
    trim = trim,
}
