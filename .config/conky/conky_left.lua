conky.config = {
	alignment = 'top_left',
	background = true,
	default_color = 'C1D5DA',
	color0 = '30383F',
	color1 = '855959',
	color2 = '4C626A',
	color3 = '81877B',
	color4 = '3E5661',
	color5 = '5E7A85',
	color6 = '72949F',
	cpu_avg_samples = 2,
	double_buffer = true,
	font = 'Share Tech Mono:size=14:style=regular',
	draw_shades = false,
	draw_borders = false,
	border_inner_margin = 0,
	border_outer_margin = 0,
	border_width = 2,
	gap_x = 25,
	gap_y = 50,
	minimum_width= 400,
	maximum_width= 400,
	no_buffers = true,
	own_window = true,
	own_window_type = 'override',
	own_window_transparent = true,
	update_interval = 1,
	use_xft = true,
	draw_graph_borders = false,
}

conky.text = [[

# TIME
${voffset -33}${color6}${alignc}${font Share Tech Mono:size=40}${time %H:%M:%S}${font}

# MONTH / YEAR / DAY / DATE
${color5}${alignc}${time %B %Y %A %d}

${color4}${hr}

# SYSTEM
# USERNAME / HOSTNAME
${color6}SYSTEM
${color4}USERNAME\
${alignr}${color6}${execi 60 whoami}
${color4}HOSTNAME\
${alignr}${color5}${execi 60 hostname}

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

${color4}${hr}

# BATTERY / STATUS
${color6}BATTERY
${color4}STATUS\
${alignr}${color5}${battery_status}
${color4}PERCENTAGE\
${alignr}${if_match ${battery_percent}>20}${color2}${battery_percent}${else}${color1}${battery_percent}${endif}%

${color4}${hr}

# RESOURCES
${color6}MEMORY USAGE
${color4}RAM\
${alignr}${color5}${mem} of ${memmax}
${color4}SWAP\
${alignr}${color2}${swap} of ${swapmax}

# RAM BAR
${color4}${memgraph 80,400}

${color6}TOP RAM PROCESSES\
${alignr}${color0}PID | NAME | RAM
${color4}${top_mem pid 1}${goto 80}${color6}${top_mem name 1}${alignr}${color2}${top_mem mem 1}%
${color4}${top_mem pid 2}${goto 80}${color6}${top_mem name 2}${alignr}${color2}${top_mem mem 2}%
${color4}${top_mem pid 3}${goto 80}${color6}${top_mem name 3}${alignr}${color2}${top_mem mem 3}%
${color4}${top_mem pid 4}${goto 80}${color6}${top_mem name 4}${alignr}${color2}${top_mem mem 4}%
${color4}${top_mem pid 5}${goto 80}${color6}${top_mem name 5}${alignr}${color2}${top_mem mem 5}%
${color4}${top_mem pid 6}${goto 80}${color6}${top_mem name 6}${alignr}${color2}${top_mem mem 6}%
${color4}${top_mem pid 7}${goto 80}${color6}${top_mem name 7}${alignr}${color2}${top_mem mem 7}%
${color4}${top_mem pid 8}${goto 80}${color6}${top_mem name 8}${alignr}${color2}${top_mem mem 8}%
${color4}${top_mem pid 9}${goto 80}${color6}${top_mem name 9}${alignr}${color2}${top_mem mem 9}%
${color4}${top_mem pid 10}${goto 80}${color6}${top_mem name 10}${alignr}${color2}${top_mem mem 10}%

]];
