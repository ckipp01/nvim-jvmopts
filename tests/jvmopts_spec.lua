local jvmopts = require("jvmopts")

describe("jvmopts", function()
  it("can correctly retrieve JAVA_OPTS", function()
    local java_env_opts = jvmopts.java_opts_from_env()
    assert.are.same({ "-Xss4m", "-Xms1G" }, java_env_opts)
  end)

  it("can correctly retrieve JAVA_FLAGS", function()
    local java_env_flags = jvmopts.java_flags_from_env()
    assert.are.same({ "-Xmx2G", "-XX:ReservedCodeCacheSize=1024m" }, java_env_flags)
  end)

  it("can correctly retrieve all supported Java env stuff", function()
    local java_env = jvmopts.java_env()
    assert.are.same({ "-Xss4m", "-Xms1G", "-Xmx2G", "-XX:ReservedCodeCacheSize=1024m" }, java_env)
  end)

  it("can correctly retrieve from a .jvmopts file", function()
    local jvmopts_from_file = jvmopts.java_opts_from_file(vim.fn.getcwd() .. "/tests")
    assert.are.same({ "-XX:+TieredCompilation", "-Dfile.encoding=UTF-8" }, jvmopts_from_file)
  end)

  it("can correctly retrieve all relevant java options", function()
    local all_jvm_opts = jvmopts.java_opts(vim.fn.getcwd() .. "/tests")
    assert.are.same({
      "-Xss4m",
      "-Xms1G",
      "-Xmx2G",
      "-XX:ReservedCodeCacheSize=1024m",
      "-XX:+TieredCompilation",
      "-Dfile.encoding=UTF-8",
    }, all_jvm_opts)
  end)
end)
