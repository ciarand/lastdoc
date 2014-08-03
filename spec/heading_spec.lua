local doc = require "lastdoc"

local block = function(str)
    return doc.block(doc.gen(str))
end

describe("the heading parsing logic", function()
    it("should return an empty block when passed an empty string", function()
        assert.is.same({
            header = nil,
            body = ""
        }, block(""))
    end)

    pending("should parse a normal #-style header w/ one line of text", function()
        assert.is.same({
            header = "lastdoc",
            body = "is a cool library"
        }, block("# lastdoc\n\nis a cool library"))
    end)
end)
