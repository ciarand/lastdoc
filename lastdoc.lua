local splitter = function(s, sep)
    local exp = {}
    local i = 0
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

local gen_doc = function(str)
    local exp = {}

    exp.content = str

    exp.lines = splitter(exp.content, "\n")
    exp.count = #exp.lines

    exp.line = function(i)
        return exp.lines[i]
    end

    return exp
end

local title = function(doc)
    if doc.count < 1 then
        return nil
    end

    local str = doc.line(0)
    local dec = doc.line(1)

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

return {
    gen   = gen_doc,
    title = title,
}
