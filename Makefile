format:
	stylua lua/ tests/*.lua

format-check:
	stylua --check lua/ tests/*.lua

lint:
	luacheck lua/ tests/*.lua

test: export JAVA_OPTS = -Xss4m -Xms1G
test: export JAVA_FLAGS = -Xmx2G -XX:ReservedCodeCacheSize=1024m

test:
	nvim --headless --noplugin -u tests/minimal.vim -c "PlenaryBustedDirectory tests/ { minimal_init = 'tests/minimal.vim' }"

