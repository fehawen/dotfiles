conky.config = {
	alignment = 'top_right',
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

# PUBLIC IP
${voffset -31}${color6}${alignc}${font Share Tech Mono:size=30}${execi 60 curl ipinfo.io/ip}${font}
# LOCAL IP
${color6}${alignc}${font Share Tech Mono:size=30}${addrs wlp2s0}${font}

${color4}${hr}

# NETWORK
${color6}NETWORK STATUS
${color4}MODE\
${alignr}${color4}${wireless_mode wlp2s0}
${color4}ESSID\
${alignr}${if_match "${wireless_essid wlp2s0}"=="off/any"}${color1}disconnected${else}${color6}${wireless_essid wlp2s0}${endif}
${color4}ACCESS POINT\
${alignr}${color4}${wireless_ap wlp2s0}

${color4}${hr}

${color6}NETWORK TRAFFIC
${color4}DOWN\
${alignr}${color2}${downspeedf wlp2s0} KiB/s (${totaldown wlp2s0})
${color4}UP\
${alignr}${color2}${upspeedf wlp2s0} KiB/s (${totalup wlp2s0})

${color4}${hr}

# STORAGE
${color6}STORAGE
${color4}SSD /\
${alignr}${color6}${fs_used /} of ${fs_size /}

${color4}${hr}

# CPU USAGE
${color6}CPU USAGE
${color4}PERC\
${alignr}${color5}${cpu}%
${color4}FREQ\
${alignr}${color2}${freq_g}GHz

# CPU BARS
${color2}CPU \#1\
${goto 200}${color5}CPU \#2
${color2}${cpugraph cpu1 50,190}\
${goto 200}${color5}${cpugraph cpu2 50,200}

${color6}CPU \#3\
${goto 200}${color4}CPU \#4
${color6}${cpugraph cpu3 50,190}\
${goto 200}${color4}${cpugraph cpu4 50,200}

${color6}TOP CPU PROCESSES\
${alignr}${color0}PID | NAME | CPU
${color4}${top pid 1}${goto 80}${color6}${top name 1}${alignr}${color2}${top cpu 1}%
${color4}${top pid 2}${goto 80}${color6}${top name 2}${alignr}${color2}${top cpu 2}%
${color4}${top pid 3}${goto 80}${color6}${top name 3}${alignr}${color2}${top cpu 3}%
${color4}${top pid 4}${goto 80}${color6}${top name 4}${alignr}${color2}${top cpu 4}%
${color4}${top pid 5}${goto 80}${color6}${top name 5}${alignr}${color2}${top cpu 5}%
${color4}${top pid 6}${goto 80}${color6}${top name 6}${alignr}${color2}${top cpu 6}%
${color4}${top pid 7}${goto 80}${color6}${top name 7}${alignr}${color2}${top cpu 7}%
${color4}${top pid 8}${goto 80}${color6}${top name 8}${alignr}${color2}${top cpu 8}%
${color4}${top pid 9}${goto 80}${color6}${top name 9}${alignr}${color2}${top cpu 9}%
${color4}${top pid 10}${goto 80}${color6}${top name 10}${alignr}${color2}${top cpu 10}%

]];
