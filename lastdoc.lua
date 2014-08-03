local splitter = function(s, sep)
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

local gen_doc = function(str)
    local exp = {}

    exp.content = str

    exp.lines = splitter(exp.content, "\n")
    -- there's always at least one line here
    exp.count = #exp.lines

    exp.line = function(i)
        return exp.lines[i]
    end

    return exp
end

local two_line_title = function(doc)
    local str = doc.line(1)
    local dec = doc.line(2)

    local str_len = str:len()
    local dec_len = dec:len()

    if dec_len > (str_len + 2) or dec_len < (str_len - 2) then
        return nil
    end

    if dec ~= string.rep("=", dec_len) then
        return nil
    end

    return str
end

local one_line_title = function(doc)
    return trim(doc.line(1):match("= ?([^=]+)=?"))
end

local title = function(doc)
    -- if we don't even have a line, just die
    if doc.count < 1 then
        return nil
    elseif doc.count == 1 then
        return one_line_title(doc)
    else
        return two_line_title(doc)
    end
end

return {
    gen   = gen_doc,
    title = title,
}
