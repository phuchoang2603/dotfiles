return {
	-- snacks.nvim
	{
		"folke/snacks.nvim",
		opts = {
			scroll = {
				enabled = false, -- Disable scrolling animations
			},
			dashboard = {
				sections = {
					{ section = "header" },
					{ section = "keys", padding = 1 },
					{ section = "recent_files", padding = 1 },
					{ section = "projects", padding = 1 },
					{
						section = "terminal",
						enabled = function()
							return Snacks.git.get_root() ~= nil
						end,
						cmd = "git status --short --branch --renames",
						height = 5,
						padding = 1,
						ttl = 5 * 60,
					},
					{ section = "startup" },
				},
			},
			explorer = {
				enabled = false,
			},
		},
		keys = {
			{ "<leader>e", false },
			{ "<leader>E", false },
		},
	},
	-- yazi.nvim
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = {
			"folke/snacks.nvim",
		},
		keys = {
			{
				"<leader>e",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				"<leader>E",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = true,
			keymaps = {
				show_help = "<f1>",
			},
		},
		init = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	-- bufferline.nvim
	{
		"akinsho/bufferline.nvim",
		enabled = false,
	},
	-- guess-indent.nvim
	{ "nmac427/guess-indent.nvim", opts = { auto_cmd = true, override_editorconfig = true } },
	-- nvim-spider
	{
		"chrisgrieser/nvim-spider",
		opts = {},
		keys = {
			{
				"w",
				"<cmd>lua require('spider').motion('w')<CR>",
				mode = { "n", "o", "x" },
				desc = "Move to start of next of word",
			},
			{
				"e",
				"<cmd>lua require('spider').motion('e')<CR>",
				mode = { "n", "o", "x" },
				desc = "Move to end of word",
			},
			{
				"b",
				"<cmd>lua require('spider').motion('b')<CR>",
				mode = { "n", "o", "x" },
				desc = "Move to start of previous word",
			},
		},
	},
	-- remote-nvim
	{
		"amitds1997/remote-nvim.nvim",
		version = "*", -- Pin to GitHub releases
		dependencies = {
			"nvim-lua/plenary.nvim", -- For standard functions
			"MunifTanjim/nui.nvim", -- To build the plugin UI
			"nvim-telescope/telescope.nvim", -- For picking b/w different remote methods
		},
		config = true,
	},
}
