local jvmopts = require("jvmopts")

describe("jvmopts", function()
  it("can correctly retrieve JAVA_OPTS", function()
    local envopts = jvmopts.java_opts_from_env()
    assert.are.same({"-Xss4m", "-Xms1G"}, envopts)
  end)
end)
