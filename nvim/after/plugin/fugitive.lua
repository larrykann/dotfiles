vim.keymap.set("n", "<leader>gs", vim.cmd.Git);

-- Keybinding to run `git add .`
vim.keymap.set("n", "<leader>ga", function()
    vim.cmd('Git add .')
end, { desc = "Git add all changes" })

-- 'git commit -m' with custom message prompt
vim.keymap.set("n", "<leader>gc", function()
    local commit_message = vim.fn.input("Commit message: ")

    if commit_message ~= "" then
        vim.cmd('Git commit -m "' .. commit_message .. '"')
    else
        print("Commit message cannot be empty.")
    end
end, { desc = "Git commit with message" })

-- Keybinding to run `git merge` with a prompt for branch name
vim.keymap.set("n", "<leader>gm", function()
    local branches = vim.fn.systemlist("git branch --format='%(refname:short)'")

    if #branches == 0 then
        print("No branches found to merge.")
        return
    end

    vim.ui.select(branches, { prompt = "Select a branch to merge:" }, function(selected_branch)
        if selected_branch then
            vim.cmd('Git merge ' .. selected_branch)
        else
            print("Merge operation canceled.")
        end
    end)
end, { desc = "Git merge with branch selection" })

