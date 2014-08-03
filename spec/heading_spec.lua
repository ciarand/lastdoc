local doc = require "lastdoc"

describe("the heading parsing stuff", function()
    local title = function(str)
        return doc.title(doc.gen(str))
    end
    local author = function(str)
        return doc.author(doc.gen(str))
    end

    describe("normal headers", function()
        it("should parse a doc with a normal header", function()
            assert.is.same("lastdoc", title("lastdoc\n=======\n"))
            assert.is.same("lastdoc", title("lastdoc\n======="))
        end)
        it("should parse a doc with a normal header - 1", function()
            assert.is.same("lastdoc", title("lastdoc\n======\n"))
            assert.is.same("lastdoc", title("lastdoc\n======"))
        end)
        it("should parse a doc with a normal header - 2", function()
            assert.is.same("lastdoc", title("lastdoc\n=====\n"))
            assert.is.same("lastdoc", title("lastdoc\n====="))
        end)
        it("should parse a doc with a normal header + 1", function()
            assert.is.same("lastdoc", title("lastdoc\n========\n"))
            assert.is.same("lastdoc", title("lastdoc\n========"))
        end)
        it("should parse a doc with a normal header + 2", function()
            assert.is.same("lastdoc", title("lastdoc\n=========\n"))
            assert.is.same("lastdoc", title("lastdoc\n========="))
        end)

        it("should not parse a doc with a normal header - 3", function()
            assert.is_not.same("lastdoc", title("lastdoc\n====\n"))
            assert.is_not.same("lastdoc", title("lastdoc\n===="))
        end)
        it("should not parse a doc with a normal header + 3", function()
            assert.is_not.same("lastdoc", title("lastdoc\n==========\n"))
            assert.is_not.same("lastdoc", title("lastdoc\n=========="))
        end)
    end)

    describe("one-line headers", function()
        it("should parse a one-line header with no right delim", function()
            assert.is.same("lastdoc", title("= lastdoc"))
        end)
        it("should parse a one-line header with a right delim", function()
            assert.is.same("lastdoc", title("= lastdoc ="))
        end)
        it("should parse a one-line header with no right delim and no left ws", function()
            assert.is.same("lastdoc", title("=lastdoc"))
        end)
        it("should parse a one-line header with a right delim and no left ws", function()
            assert.is.same("lastdoc", title("=lastdoc ="))
        end)
    end)

    describe("author info", function()
        it("should parse a first name", function()
            assert.is.same(author("John"),
                { first_name = "John" })
        end)
        pending("should parse a first and last name", function()
            assert.is.same(author("John Smith"),
                { first_name = "John", last_name = "Smith" })
        end)
        pending("should parse a first, middle, and last name", function()
            assert.is.same(author("John Danger Smith"),
                { first_name = "John", middle_name = "Danger", last_name = "Smith" })
        end)
        pending("should parse a first name and email", function()
            assert.is.same(author("John Danger Smith <john@example.com>"),
                {
                    first_name = "John",
                    middle_name = "Danger",
                    last_name = "Smith",
                    email = "john@example.com",
                })
        end)
    end)
end)
