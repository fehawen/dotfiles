conky.config = {
	alignment = 'top_left',
	background = true,
	default_color = '8E9A9B',
	color0 = '41515C',
	color1 = 'AE5151',
	color2 = '779687',
	color3 = 'B98675',
	color4 = '5E828F',
	color5 = 'B48291',
	color6 = '7AB1B3',
	cpu_avg_samples = 2,
	diskio_avg_samples = 2,
	double_buffer = true,
	font = 'Roboto Mono:size=12:style=regular',
	font2 = 'Roboto Mono:size=12:style=bold',
	draw_shades = false,
	draw_outline = false,
	draw_borders = false,
	draw_graph_borders = false,
	border_inner_margin = 0,
	border_outer_margin = 0,
	border_width = 0,
	stippled_borders = 0,
	pad_percents = 0,
	gap_x = 24,
	gap_y = 0,
	maximum_width = 300,
	minimum_width = 300,
	no_buffers = true,
	out_to_console = false,
	out_to_ncurses = false,
	out_to_stderr = false,
	out_to_x = true,
	own_window = true,
	own_window_type = 'override',
	own_window_transparent = true,
	update_interval = 1,
	use_xft = true,
	uppercase = false,
}

conky.text = [[

# DATE
${color}${alignc}${font Roboto Mono:size=30}${time %a, %b %d}${font}

${color0}${hr}

# SYSTEM
# USERNAME / HOSTNAME
${font2}${color1}SYSTEM${font}
${color}USERNAME\
${alignr}${color6}${user_names}
${color}HOSTNAME\
${alignr}${color5}${nodename}
${color}CONSOLES\
${alignr}${color2}${user_terms}

# UPTIME / KERNEL
${color}UPTIME\
${alignr}${color3}${uptime}
${color}KERNEL\
${alignr}${color4}${kernel}

# LAST UPDATED / PACKAGES
${color}PACKAGES\
${alignr}${color5}${execi 3600 sudo pacman -Q | wc -l}
${color}UPDATED\
${alignr}${color6}${execi 3600 ~/.local/bin/pacupdate}

${color0}${hr}

# CONTROLS
${font2}${color1}CONTROLS${font}
${color}BACKLIGHT\
${alignr}${color5}${exec xbacklight -get | cut -d. -f1}%
${color}VOLUME\
${alignr}${color3}${exec pamixer --get-volume-human}

${color0}${hr}

# BATTERY / STATUS
${font2}${color1}BATTERY${font}
${color}PERCENTAGE\
${alignr}${if_match ${battery_percent}>20}${color2}${battery_percent}${else}${color1}${battery_percent}${endif}%
${color}STATUS\
${alignr}${color4}${battery_status}

${color0}${hr}

# STORAGE
${font2}${color1}STORAGE${font}
${color}USED /\
${alignr}${color3}${fs_used /} of ${fs_size /}
${color}TYPE /\
${alignr}${color2}${fs_type /}

${color0}${hr}

# DISK I/O
${font2}${color1}I/O\
${alignr}SIZE${font}

${color6}READ\
${alignr}${diskio_read}
${diskiograph_read 60,300}

${color5}WRITE\
${alignr}${diskio_write}
${diskiograph_write 60,300}

# MEMORY
${font2}${color1}MEMORY USAGE${font}
${color}BUFFERS\
${alignr}${color6}${buffers}
${color}CACHED\
${alignr}${color4}${cached}
${color}SWAP\
${alignr}${color5}${swap} of ${swapmax}
${color}RAM\
${alignr}${color2}${mem} of ${memmax}

# RAM BAR
${color2}${memgraph 60,300}

# TOP RAM
${font2}${color1}TOP RAM\
${alignr}${color0}PID | NAME | RAM${font}
${color}${top_mem pid 1}${goto 65}${color4}${top_mem name 1}${alignr}${color5}${top_mem mem 1}%
${color}${top_mem pid 2}${goto 65}${color4}${top_mem name 2}${alignr}${color5}${top_mem mem 2}%
${color}${top_mem pid 3}${goto 65}${color4}${top_mem name 3}${alignr}${color5}${top_mem mem 3}%
${color}${top_mem pid 4}${goto 65}${color4}${top_mem name 4}${alignr}${color5}${top_mem mem 4}%
${color}${top_mem pid 5}${goto 65}${color4}${top_mem name 5}${alignr}${color5}${top_mem mem 5}%
${color}${top_mem pid 6}${goto 65}${color4}${top_mem name 6}${alignr}${color5}${top_mem mem 6}%
${color}${top_mem pid 7}${goto 65}${color4}${top_mem name 7}${alignr}${color5}${top_mem mem 7}%
${color}${top_mem pid 8}${goto 65}${color4}${top_mem name 8}${alignr}${color5}${top_mem mem 8}%
${color}${top_mem pid 9}${goto 65}${color4}${top_mem name 9}${alignr}${color5}${top_mem mem 9}%
${color}${top_mem pid 10}${goto 65}${color4}${top_mem name 10}${alignr}${color5}${top_mem mem 10}%

]];
