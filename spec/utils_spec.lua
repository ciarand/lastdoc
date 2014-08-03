local utils = require "utils"

describe("the utils module", function()
    describe("the split function", function()
        it("should correctly split on newlines", function()
            assert.is.same({"hello", "world", ""},
                utils.split("hello\nworld\n", "\n"))
        end)
        it("should correctly split on spaces", function()
            assert.is.same({"hello", "world", ""},
                utils.split("hello world ", " "))
        end)
    end)

    describe("the trim function", function()
        it("should strip regular spaces", function()
            assert.is.same("lastdoc", utils.trim(" lastdoc   "))
            assert.is.same("lastdoc", utils.trim(" lastdoc"))
            assert.is.same("lastdoc", utils.trim("lastdoc   "))
        end)

        it("should strip tabs", function()
            assert.is.same("lastdoc", utils.trim("\tlastdoc\t"))
            assert.is.same("lastdoc", utils.trim("\t\t\tlastdoc\t"))
            assert.is.same("lastdoc", utils.trim("\tlastdoc\t\t\t"))
            assert.is.same("lastdoc", utils.trim("\tlastdoc"))
            assert.is.same("lastdoc", utils.trim("lastdoc\t"))
        end)
    end)

    describe("the getor function", function()
        it("should use the provided string when it's not nil or ''", function()
            assert.is.same("lastdoc", utils.getor("lastdoc", "nope"))
        end)

        it("should use the default when passed in nil", function()
            assert.is.same("lastdoc", utils.getor(nil, "lastdoc"))
        end)

        it("should use the default when passed in an empty string", function()
            assert.is.same("lastdoc", utils.getor("", "lastdoc"))
        end)
    end)
end)
