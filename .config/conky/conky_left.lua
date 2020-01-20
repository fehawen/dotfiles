conky.config = {
	alignment = 'top_left',
	background = true,
	default_color = '3E5661',
	color0 = '30383F',
	color1 = '855959',
	color2 = '4C626A',
	color3 = '81877B',
	color4 = '3E5661',
	color5 = '5E7A85',
	color6 = '72949F',
	cpu_avg_samples = 2,
	diskio_avg_samples = 2,
	double_buffer = true,
	font = 'Share Tech Mono:size=14:style=regular',
	draw_shades = false,
	draw_outline = false,
	draw_borders = false,
	draw_graph_borders = false,
	border_inner_margin = 0,
	border_outer_margin = 0,
	border_width = 0,
	stippled_borders = 0,
	pad_percents = 0,
	gap_x = 28,
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
${color4}${alignc}${font Share Tech Mono:size=30}${time %a, %b %d}${font}

${color1}${hr}

# SYSTEM
# USERNAME / HOSTNAME
${color6}SYSTEM
${color4}USERNAME\
${alignr}${color6}${user_names}
${color4}HOSTNAME\
${alignr}${color5}${nodename}
${color4}CONSOLES\
${alignr}${color2}${user_terms}

# UPTIME / KERNEL
${color4}UPTIME\
${alignr}${color4}${uptime}
${color4}KERNEL\
${alignr}${color2}${kernel}

# LAST UPDATED / PACKAGES
${color4}UPDATED\
${alignr}${color6}${execi 3600 ~/.local/bin/pacupdate}
${color4}PACKAGES\
${alignr}${color5}${execi 3600 sudo pacman -Q | wc -l}

${color1}${hr}

# CONTROLS
${color6}CONTROLS
${color4}VOLUME\
${alignr}${color6}${exec pamixer --get-volume-human}
${color4}BACKLIGHT\
${alignr}${color5}${exec xbacklight -get | cut -d. -f1}%

${color1}${hr}

# BATTERY / STATUS
${color6}BATTERY
${color4}STATUS\
${alignr}${color5}${battery_status}
${color4}PERCENTAGE\
${alignr}${if_match ${battery_percent}>20}${color3}${battery_percent}${else}${color1}${battery_percent}${endif}%

${color1}${hr}

# STORAGE
${color6}STORAGE
${color4}USED /\
${alignr}${color6}${fs_used /} of ${fs_size /}
${color4}TYPE /\
${alignr}${color2}${fs_type /}

${color5}I/O DISK READS
${diskiograph_read 60,300}

${color2}I/O DISK WRITES
${diskiograph_write 60,300}

# MEMORY
${color6}MEMORY USAGE
${color4}BUFFERS\
${alignr}${color2}${buffers}
${color4}CACHED\
${alignr}${color4}${cached}
${color4}SWAP\
${alignr}${color5}${swap} of ${swapmax}
${color4}RAM\
${alignr}${color3}${mem} of ${memmax}

# RAM BAR
${color3}${memgraph 60,300}

# TOP RAM
${color6}TOP RAM\
${alignr}${color4}PID | NAME | RAM
${color4}${top_mem pid 1}${goto 65}${color6}${top_mem name 1}${alignr}${color2}${top_mem mem 1}%
${color4}${top_mem pid 2}${goto 65}${color6}${top_mem name 2}${alignr}${color2}${top_mem mem 2}%
${color4}${top_mem pid 3}${goto 65}${color6}${top_mem name 3}${alignr}${color2}${top_mem mem 3}%
${color4}${top_mem pid 4}${goto 65}${color6}${top_mem name 4}${alignr}${color2}${top_mem mem 4}%
${color4}${top_mem pid 5}${goto 65}${color6}${top_mem name 5}${alignr}${color2}${top_mem mem 5}%
${color4}${top_mem pid 6}${goto 65}${color6}${top_mem name 6}${alignr}${color2}${top_mem mem 6}%
${color4}${top_mem pid 7}${goto 65}${color6}${top_mem name 7}${alignr}${color2}${top_mem mem 7}%
${color4}${top_mem pid 8}${goto 65}${color6}${top_mem name 8}${alignr}${color2}${top_mem mem 8}%
${color4}${top_mem pid 9}${goto 65}${color6}${top_mem name 9}${alignr}${color2}${top_mem mem 9}%
${color4}${top_mem pid 10}${goto 65}${color6}${top_mem name 10}${alignr}${color2}${top_mem mem 10}%

]];
