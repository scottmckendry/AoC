test:
	cp ./tests/*.odin . # keeps tests in seperate directory
	odin test . -vet -strict-style -out:test_build
	rm *_test.odin
	rm test_build

bench:
	odin run .  -out:2021 -- -benchmark
	rm 2021
