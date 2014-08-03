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
            assert.is.same({
                    first_name = "John",
                    middle_name = nil,
                    last_name = nil,
                    email = nil,
                }, author("John"))
        end)
        it("should parse a complicated first name", function()
            assert.is.same({
                    first_name = "John Hello Blah",
                    middle_name = nil,
                    last_name = nil,
                    email = nil,
                }, author("John_Hello_Blah"))
        end)
        it("should parse a first and last name", function()
            assert.is.same({
                    first_name = "John",
                    middle_name = nil,
                    last_name = "Smith",
                    email = nil,
                }, author("John Smith"))
        end)
        it("should parse a complicated first and last name", function()
            assert.is.same({
                    first_name = "John Danger",
                    middle_name = nil,
                    last_name = "Smith",
                    email = nil,
                }, author("John_Danger Smith"))
        end)
        it("should parse a first, middle, and last name", function()
            assert.is.same({
                    first_name = "John",
                    middle_name = "Danger",
                    last_name = "Smith",
                    email = nil,
                }, author("John Danger Smith"))
        end)
        it("should parse a complicated first, middle, and last name", function()
            assert.is.same({
                    first_name = "John Foo",
                    middle_name = "Danger Bar",
                    last_name = "Smith Baz",
                    email = nil,
                }, author("John_Foo Danger_Bar Smith_Baz"))
        end)
        it("should parse a name and email", function()
            assert.is.same({
                    first_name = "John",
                    middle_name = "Danger",
                    last_name = "Smith",
                    email = "john@example.com",
                }, author("John Danger Smith <john@example.com>"))
        end)
        it("should parse a complicated name and email", function()
            assert.is.same({
                    first_name = "John Foo",
                    middle_name = "Danger Bar",
                    last_name = "Smith Baz",
                    email = "john@example.com",
                }, author("John_Foo Danger_Bar Smith_Baz <john@example.com>"))
        end)
    end)
end)
