conky.config = {
	alignment = 'top_left',
	background = true,
	default_color = 'FCFCFC',
	color0 = '808080',
	color1 = 'D54949',
	color2 = 'C7AA9C',
	color3 = 'D4BAAD',
	color4 = 'C6BABA',
	color5 = 'D4BCBC',
	color6 = 'B9B9B9',
	cpu_avg_samples = 2,
	diskio_avg_samples = 2,
	double_buffer = true,
	font = 'Roboto Mono:size=12:style=regular',
	draw_shades = false,
	draw_outline = false,
	draw_borders = false,
	draw_graph_borders = false,
	border_inner_margin = 0,
	border_outer_margin = 48,
	border_width = 0,
	stippled_borders = 0,
	pad_percents = 0,
	gap_x = 80,
	gap_y = 80,
	maximum_width = 130,
	minimum_width = 130,
	no_buffers = true,
	out_to_console = false,
	out_to_ncurses = false,
	out_to_stderr = false,
	out_to_x = true,
	own_window = true,
	own_window_type = 'desktop',
	own_window_transparent = false,
	own_window_colour = '232323',
	update_interval = 1,
	use_xft = true,
	uppercase = false,
}

conky.text = [[
# CLOCK
${color0}clk${color} ${time %H:%M}

# LAST UPDATED
${color0}syu${color} ${execi 3600 ~/.local/bin/pacupdate}

# BATTERY
${color0}bat${color}${if_match ${battery_percent}>20}${color}${else}${color2}${endif} ${battery_percent}%

# BACKLIGHT
${color0}bri${color} ${exec xbacklight -get | cut -d. -f1}%

# VOLUME
${color0}vol${color} ${exec pamixer --get-volume-human}

# CPU
${color0}cpu${color} ${cpu cpu0}%

# RAM
${color0}ram${color} ${memperc}%

# SWAP
${color0}swp${color} ${swapperc}%

# STORAGE
${color0}ssd${color} ${fs_used_perc /}%
]];
