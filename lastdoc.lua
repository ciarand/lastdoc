local utils = require "utils"

local gen_doc = function(str)
    local exp = {}

    exp.content = str

    exp.lines = utils.split(exp.content, "\n")
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
    return utils.trim(doc.line(1):match("= ?([^=]+)=?"))
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

local author = function(doc)
    local fname, mname, lname, email = doc.line(1):match("([%w_]+) ?([%w_]*) ?([%w_]*) ?<?([^%s<>]*)>?")

    if lname == "" and mname ~= "" then
        lname = mname
        mname = ""
    end

    return {
        first_name  = utils.getor(fname, nil),
        middle_name = utils.getor(mname, nil),
        last_name   = utils.getor(lname, nil),
        email       = utils.getor(email, nil),
    }
end

return {
    gen   = gen_doc,
    title = title,
    author = author,
}
