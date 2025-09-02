-- lua/notes.lua
local M = {}

-- Resolve your scripta/notes dir robustly on Windows
local scripta_root = vim.fs.normalize((vim.env.USERPROFILE or vim.fn.expand("~")) .. "/Documents/scripta")
local notes_dir    = vim.fs.normalize(scripta_root .. "/notes")

-- turn "My Title!!  " -> "my-title"
local function slugify(s)
  s = s:lower()
  s = s:gsub("[^%w%s%-_]", "")  -- drop punctuation
  s = s:gsub("%s+", "-")        -- spaces -> hyphens
  s = s:gsub("%-+", "-")        -- collapse dashes
  s = s:gsub("^%-+", ""):gsub("%-+$", "")
  return s ~= "" and s or "note"
end

function M.new_note()
  if vim.fn.isdirectory(notes_dir) == 0 then
    vim.fn.mkdir(notes_dir, "p")
  end

  local title = vim.fn.input("New note title: ")
  if title == "" then return end

  -- timestamp + underscore + slug
  local ts    = os.date("%Y%m%d-%H%M%S")
  local slug  = slugify(title)
  local id    = ts .. "_" .. slug
  local path  = vim.fs.joinpath(notes_dir, id .. ".md")

  if vim.fn.filereadable(path) == 0 then
    -- ISO 8601 with local offset
    local function iso8601()
      local t = os.time()
      local off = os.difftime(t, os.time(os.date("!*t", t)))
      local sign = off >= 0 and "+" or "-"
      off = math.abs(off)
      local hh = math.floor(off / 3600)
      local mm = math.floor((off % 3600) / 60)
      return os.date("%Y-%m-%dT%H:%M:%S") .. string.format("%s%02d:%02d", sign, hh, mm)
    end

    local fm = {
      "---",
      "id: " .. id,
      "date: " .. iso8601(),
      "tags: []",
      "---",
      "",
      "# " .. title,
      "",
    }
    vim.fn.writefile(fm, path)
  end

  vim.cmd.edit(path)
end

return M
