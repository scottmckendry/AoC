ifeq ($(OS),Windows_NT)
    RM = del
    CP = xcopy /y > NUL
    PS = \\
    EXE = .exe
else
    RM = rm
    CP = cp
    PS = /
    EXE =
endif

test:
	$(CP) .$(PS)tests$(PS)*.odin .
	odin test . -vet -strict-style -out:test_build$(EXE)
	$(RM) *_test.odin
	$(RM) test_build$(EXE)

bench:
	odin run . -out:2021$(EXE) -- -benchmark
	$(RM) 2021$(EXE)
