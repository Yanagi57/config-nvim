local wk = require("which-key")
-- As an example, we will create the following mappings:
--  * <leader>ff find files
--  * <leader>fr show recent files
--  * <leader>fb Foobar
-- we'll document:
--  * <leader>fn new file
--  * <leader>fe edit file
-- and hide <leader>1
wk.setup()
wk.add({
	{ "<leader>c", group = "[C]ode" },
	{ "<leader>c_", hidden = true },
	{ "<leader>d", group = "[D]ocument" },
	{ "<leader>d_", hidden = true },
	{ "<leader>s", group = "[S]earch" },
	{ "<leader>s_", hidden = true },
	{ "<leader>w", group = "[W]orkspace" },
	{ "<leader>w_", hidden = true },
}, { prefix = "<leader>" })
