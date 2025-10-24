require("clipboard-image").setup({
	-- Default configuration for all filetype
	default = {
		img_dir = "Assets/Screenshots",
		img_name = function()
			return os.date("%Y-%m-%dT%H-%M-%S")
		end, -- Example result: "2021-04-13T10-04-18"
		affix = "![](%s)", -- Multi lines affix
	},
	-- You can create configuration for ceartain filetype by creating another field (markdown, in this case)
	-- If you're uncertain what to name your field to, you can run `lua print(vim.bo.filetype)`
	-- Missing options from `markdown` field will be replaced by options from `default` field
	markdown = {
		img_dir = { "Assets", "Screenshots" }, -- Use table for nested dir (New feature form PR #20)
		img_dir_txt = "./Assets/Screenshots",
		-- img_handler = function(img) -- New feature from PR #22
		-- 	local script = string.format('./image_compressor.sh "%s"', img.path)
		-- 	os.execute(script)
		-- end,
	},
})

vim.keymap.set("n", "<leader>ip", "<cmd>PasteImg<CR>", { desc = "[I]mage [P]aste" })
