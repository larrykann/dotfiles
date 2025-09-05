local M            = {}

local scripta_root = vim.fs.normalize((vim.env.USERPROFILE or vim.fn.expand("~")) .. "/Documents/scripta")
local hgt_dir      = vim.fs.normalize(scripta_root .. "/hgt")

local function slugify(s)
  s = s:lower()
  s = s:gsub("[^%w%s%-_]", "") -- drop punctuation
  s = s:gsub("%s+", "-")       -- spaces -> hyphens
  s = s:gsub("%-+", "-")       -- collapse dashes
  s = s:gsub("^%-+", ""):gsub("%-+$", "")
  return s ~= "" and s or "note"
end

function M.new_post()
  if vim.fn.isdirectory(hgt_dir) == 0 then
    vim.fn.mkdir(hgt_dir, "p")
  end

  local title = vim.fn.input("New post title: ")
  if title == "" then return end

  -- timestamp + underscore + slug
  local slug = slugify(title)
  local id   = slug
  local path = vim.fs.joinpath(hgt_dir, slug .. ".md")

  if vim.fn.filereadable(path) == 0 then
    local fm = {
      "---",
      "title:" .. title,
      "id: " .. id,
      "date: " .. os.date("%Y-%m-%dT%H:%M:%S"),
      "tags: [hgt]",
      "---",
      "",
      "# " .. title,
      "",
      "",
      "",
      "> This post doesn't represent any type of advice, financial or otherwise. Its purpose is to be informative and educational. Backtest results are based on historical data, not real-time data. There is no guarantee that these hypothetical results will continue in the future. Day trading is extremely risky, and I do not suggest running any of these strategies live.",
    }
    vim.fn.writefile(fm, path)
  end

  vim.cmd.edit(path)
end

return M
