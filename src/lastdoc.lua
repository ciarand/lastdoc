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
    local res = doc.line(1):match("= ?([^=]+)=?")

    if res == nil then return end

    return utils.trim(res)
end

local title = function(doc)
    if doc.count == 1 then
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

    local dash_to_space = function(str)
        return str:gsub("_", " ")
    end

    return {
        first_name  = utils.getor(dash_to_space(fname), nil),
        middle_name = utils.getor(dash_to_space(mname), nil),
        last_name   = utils.getor(dash_to_space(lname), nil),
        email       = utils.getor(dash_to_space(email), nil),
    }
end

local block = function(doc)
    return {
        header = nil,
        body = "",
    }
end

return {
    gen    = gen_doc,
    title  = title,
    block  = block,
    author = author,
}
