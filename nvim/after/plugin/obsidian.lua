require("obsidian").setup({
    workspaces = {
        {
            name = "External Brain",
            path = "C:\\Users\\kannd\\Documents\\cyberBrain",
        },
    },
    notes_subdir = "01 Inbox",

    new_notes_location = "notes_subdir",

    mappings = {
        -- Open in Obsidian App
        ["<leader>oo"] = {
            action = "<cmd>ObsidianOpen<CR>",
            opts = { desc = "Open in Obsidian App" },
        },
        -- Open New Note
        ["<leader>on"] = {
            action = "<cmd>ObsidianNew<CR>",
            opts = { desc = "Open New Note" },
        },
        -- Quick Switch
        ["<leader>oq"] = {
            action = "<cmd>ObsidianQuickSwitch<CR>",
            opts = { desc = "Quick Switch" },
        },
        -- Show Obsidian Backlinks
        ["<leader>ob"] = {
            action = "<cmd>ObsidianBacklinks<CR>",
            opts = { desc = "Show Obsidian Backlinks" },
        },
        -- Show Obsidian Tags
        ["<leader>ot"] = {
            action = "<cmd>ObsidianTags<CR>",
            opts = { desc = "Show Obsidian Tags" },
        },
        -- Insert Obsidian Template
        ["<leader>oi"] = {
            action = "<cmd>ObsidianTemplate<CR>",
            opts = { desc = "Insert Obsidian Template" },
        },
        -- Search Obsidian
        ["<leader>os"] = {
            action = "<cmd>ObsidianSearch<CR>",
            opts = { desc = "Search Obsidian" },
        },
        -- Show Obsidian Links
        ["<leader>olk"] = {
            action = "<cmd>ObsidianLinks<CR>",
            opts = { desc = "Show Obsidian Links" },
        },
        -- Paste Image
        ["<leader>op"] = {
            action = "<cmd>ObsidianPasteImg<CR>",
            opts = { desc = "Paste Image" },
        },
        -- Create New Daily Note
        ["<leader>od"] = {
            action = "<cmd>ObsidianToday<CR>",
            opts = { desc = "Create New Daily Note" },
        },
        -- Smart Follow Link or 'gf'
        ["<leader>of"] = {
            action = function()
                if require("obsidian").util.cursor_on_markdown_link() then
                    return "<cmd>ObsidianFollowLink<CR>"
                else
                    return "gf"
                end
            end,
            opts = { noremap = false, expr = true },
        },
    },

    completion = {
        -- Set to false to disable completion.
        nvim_cmp = true,
        -- Trigger completion at 2 chars.
        min_chars = 2,
    },

    templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        -- A map for custom variables, the key should be the variable and the value a function
        substitutions = {},
    },

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
        -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
        -- In this case a note with the title 'My new note' will be given an ID that looks
        -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
        local suffix = ""
        if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
            end
        end
        return tostring(os.time()) .. "-" .. suffix
    end,

    wiki_link_func = "prepend_note_id",

    markdown_link_func = "prepend_note_id",

    preferred_link_style = "wiki",

    disable_frontmatter = false,

    daily_notes = {
        -- Optional, if you keep daily notes in a separate directory.
        folder = "02 Daily Notes",
        template = "templates/Daily Note"
    },


    -- Optional, alternatively you can customize the frontmatter data.
    ---@return table
    note_frontmatter_func = function(note)
        -- Add the title of the note as an alias.
        if note.title then
            note:add_alias(note.title)
        end

        local out = { id = note.id, aliases = note.aliases, tags = note.tags, references = {} }

        -- `note.metadata` contains any manually added fields in the frontmatter.
        -- So here we just make sure those fields are kept in the frontmatter.
        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
            for k, v in pairs(note.metadata) do
                out[k] = v
            end
        end

        return out
    end,
    picker = {
        -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
        name = "telescope.nvim",
        -- Optional, configure key mappings for the picker. These are the defaults.
        -- Not all pickers support all mappings.
        note_mappings = {
            -- Create a new note from your query.
            new = "<C-x>",
            -- Insert a link to the selected note.
            insert_link = "<C-l>",
        },
        tag_mappings = {
            -- Add tag(s) to current note.
            tag_note = "<C-x>",
            -- Insert a tag at the current location.
            insert_tag = "<C-l>",
        },
    },
    ui = { enable = true },
})

