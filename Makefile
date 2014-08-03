test:
	LUA=luajit busted

coverage: clean
	LUA=luajit busted -c

clean:
	rm -rf luacov.*.out README.html
