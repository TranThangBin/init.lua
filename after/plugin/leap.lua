local leap = require("leap")

leap.add_default_mappings()

leap.opts = {
	max_phase_one_targets = nil,
	highlight_unlabeled_phase_one_targets = false,
	max_highlighted_traversal_targets = 10,
	case_sensitive = false,
	equivalence_classes = { " \t\r\n" },
	substitute_chars = {},
	safe_labels = { "s", "f", "n", "u", "t" },
	labels = { "s", "f", "n", "j", "k" },
	special_keys = {
		next_target = "<enter>",
		prev_target = "<tab>",
		next_group = "<space>",
		prev_group = "<tab>",
		multi_accept = "<enter>",
		multi_revert = "<backspace>",
	},
}

leap.add_repeat_mappings(";", ",", {
	-- False by default. If set to true, the keys will work like the
	-- native semicolon/comma, i.e., forward/backward is understood in
	-- relation to the last motion.
	relative_directions = true,
	-- By default, all modes are included.
	modes = { "n", "x", "o" },
})
