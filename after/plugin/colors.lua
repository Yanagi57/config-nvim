-------------------------------- One Dark -------------------------------------
-- require('onedark').setup({
--   style = 'cool'
-- })
-- -- Enable theme
-- require('onedark').load()
----------------------------- Nordfox -------------------------------------
-- Default options
-- require("nightfox").setup({
-- 	options = {
-- 		-- Compiled file's destination location
-- 		compile_path = vim.fn.stdpath("cache") .. "/nightfox",
-- 		compile_file_suffix = "_compiled", -- Compiled file suffix
-- 		transparent = false, -- Disable setting background
-- 		terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
-- 		dim_inactive = false, -- Non focused panes set to alternative background
-- 		module_default = true, -- Default enable value for modules
-- 		colorblind = {
-- 			enable = false, -- Enable colorblind support
-- 			simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
-- 			severity = {
-- 				protan = 0, -- Severity [0,1] for protan (red)
-- 				deutan = 0, -- Severity [0,1] for deutan (green)
-- 				tritan = 0, -- Severity [0,1] for tritan (blue)
-- 			},
-- 		},
-- 		styles = { -- Style to be applied to different syntax groups
-- 			comments = "italic", -- Value is any valid attr-list value `:help attr-list`
-- 			conditionals = "underline",
-- 			constants = "NONE",
-- 			functions = "NONE",
-- 			keywords = "NONE",
-- 			numbers = "NONE",
-- 			operators = "NONE",
-- 			strings = "NONE",
-- 			types = "NONE",
-- 			variables = "NONE",
-- 		},
-- 		inverse = { -- Inverse highlight for different types
-- 			match_paren = false,
-- 			visual = false,
-- 			search = false,
-- 		},
-- 		modules = { -- List of various plugins and additional options
-- 			-- ...
-- 		},
-- 	},
-- 	palettes = {},
-- 	specs = {},
-- 	groups = {
-- 		all = {
-- 			IncSearch = { bg = "palette.cyan" },
-- 		},
-- 	},
-- })
--
-- -- setup must be called before loading
-- vim.cmd("colorscheme carbonfox")

----------------------------- Black & Gold (Monokai Machine fork) -------------
-- Monokai Machine palette mapping:
--   accent1 = red    (#ff6d7e) → keep as error
--   accent2 = orange (#ffb270) → keep as warning
--   accent3 = yellow (#ffed72) → gold  (keywords)
--   accent4 = green  (#a2e57b) → teal  (strings, git add)
--   accent5 = cyan   (#7cd5f1) → teal dim (types, info)
--   accent6 = purple (#baa0f8) → gold  (functions — eliminates all purple)
require("monokai-pro").setup({
	filter = "machine",
	override_palette = function(_filter)
		return {
			-- Backgrounds
			background = "#222222",
			dark1      = "#2A2A2A",
			dark2      = "#333333",
			-- Text
			text       = "#F5F5F5",
			-- Swap purple/green/cyan to gold/teal
			accent3    = "#FFD700", -- yellow → gold  (keywords)
			accent4    = "#4DD9C0", -- green  → teal  (strings)
			accent5    = "#2AA38E", -- cyan   → teal dim (types/builtins)
			accent6    = "#FFD700", -- purple → gold  (functions)
			-- Grayscale
			dimmed1    = "#BBBBBB",
			dimmed2    = "#999999",
			dimmed3    = "#777777",
			dimmed4    = "#555555",
			dimmed5    = "#3D3D3D",
		}
	end,
	override = function(c)
		return {
			-- Types and classes → primary text, not teal
			["@type"]               = { fg = "#F5F5F5" },
			["@type.builtin"]       = { fg = "#F5F5F5" },
			["@lsp.type.type"]      = { fg = "#F5F5F5" },
			["@lsp.type.class"]     = { fg = "#F5F5F5" },
			["@lsp.type.interface"] = { fg = "#F5F5F5" },
			["@lsp.type.struct"]    = { fg = "#F5F5F5" },
			-- Parameters → secondary
			["@variable.parameter"] = { fg = "#BBBBBB" },
			["@lsp.type.parameter"] = { fg = "#BBBBBB" },
			-- Variables → primary
			["@variable"]           = { fg = "#F5F5F5" },
			-- Operators → secondary
			["@operator"]           = { fg = "#BBBBBB" },
			Operator                = { fg = "#BBBBBB" },
		}
	end,
})
vim.cmd.colorscheme("monokai-pro")
