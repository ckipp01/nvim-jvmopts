local uv = vim.loop

local is_windows = uv.os_uname().version:match("Windows")
local path_sep = is_windows and "\\" or "/"

local function path_join(...)
  local result = table.concat(vim.tbl_flatten({ ... }), path_sep):gsub(path_sep .. "+", path_sep)
  return result
end

local function exists(filename)
  local stat = uv.fs_stat(filename)
  return stat and stat.type or false
end

local function merge_lists(a, b)
  if b == nil then
    return {}
  else
    local merged = vim.deepcopy(a)

    for _, v in ipairs(b) do
      if type(v) == "string" then
        table.insert(merged, v)
      end
    end

    return merged
  end
end

local function parse_env_variable(variable)
  local options = {}
  if variable == nil then
    return options
  else
    for substring in variable:gmatch("%S+") do
      table.insert(options, substring)
    end
    return options
  end
end

local function read_from_file(file)
  if exists(file) then
    local lines = {}
    for line in io.lines(file) do
      lines[#lines + 1] = line
    end
    return lines
  else
    return {}
  end
end

local function java_opts_from_env()
  return parse_env_variable(os.getenv("JAVA_OPTS"))
end

local function java_flags_from_env()
  return parse_env_variable(os.getenv("JAVA_FLAGS"))
end

local function java_env()
  return merge_lists(java_opts_from_env(), java_flags_from_env())
end

local function java_opts_from_file(workspace_root)
  if workspace_root ~= nil then
    local jvm_opts_file = path_join(workspace_root, ".jvmopts")
    local lines = read_from_file(jvm_opts_file)
    return lines
  else
    return {}
  end
end

local function java_opts(workspace)
  return merge_lists(java_env(), java_opts_from_file(workspace))
end

return {
  java_opts_from_env = java_opts_from_env,
  java_flags_from_env = java_flags_from_env,
  java_opts_from_file = java_opts_from_file,
  java_env = java_env,
  java_opts = java_opts,
}
