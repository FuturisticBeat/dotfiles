return {
  "jvgrootveld/telescope-zoxide",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    -- Create the custom user command :Cd
    vim.api.nvim_create_user_command("Cd", function(opts)
      -- Check if an argument was passed
      if opts.args ~= "" then
        -- If an argument is given, use it as the initial search term
        require("telescope").extensions.zoxide.list({
          change_cwd = true,
          default_text = opts.args,
        })
      else
        -- Otherwise, launch the zoxide Telescope picker with no search term
        require("telescope").extensions.zoxide.list({
          change_cwd = true,
        })
      end
    end, { nargs = "*", desc = "Use zoxide or Telescope to change directory" })

    -- Automatically replace `:cd` with `:Cd` in the command line
    vim.cmd([[cnoreabbrev cd Cd]])
  end,
}
