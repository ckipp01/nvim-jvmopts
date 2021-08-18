format:
	stylua lua/ tests/*.lua

format-check:
	stylua --check lua/ tests*.lua

lint:
	luacheck lua/ tests/*.lua

setup-env:
	export JAVA_OPTS="-Xss4m -Xms1G"

test:
	nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/ { minimal_init = 'tests/minimal.vim' }"

