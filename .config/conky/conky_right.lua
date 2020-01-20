conky.config = {
	alignment = 'top_right',
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

# TIME
${color4}${alignc}${font Share Tech Mono:size=40}${time %H:%M:%S}${font}

${color1}${hr}

# NETWORK
${color6}NETWORK STATUS
${color4}MODE\
${alignr}${color4}${wireless_mode wlp2s0}
${color4}ESSID\
${alignr}${if_match "${wireless_essid wlp2s0}"=="off/any"}${color1}disconnected${else}${color3}${wireless_essid wlp2s0}${endif}
${color4}GATEWAY\
${alignr}${color5}${gw_iface}
${color4}GATEWAY IP\
${alignr}${color4}${gw_ip}
${color4}LOCAL IP\
${alignr}${color2}${addrs wlp2s0}
${color4}PUBLIC IP\
${alignr}${color6}${execi 60 curl ipinfo.io/ip}
${color4}AP MAC\
${alignr}${color4}${wireless_ap wlp2s0}

${color1}${hr}

${color6}NETWORK TRAFFIC
${color4}DOWN\
${alignr}${color2}${downspeedf wlp2s0} KiB/s (${totaldown wlp2s0})
${color4}UP\
${alignr}${color2}${upspeedf wlp2s0} KiB/s (${totalup wlp2s0})

${color1}${hr}

# CPU USAGE
${color6}CPU USAGE
${color4}PERCENTAGE\
${alignr}${color5}${cpu}%
${color4}PROCESSES\
${alignr}${color5}${processes}

${color1}${hr}

# CPU GRAPHS
${color6}LOAD\
${alignr}FREQUENCY

${color6}CPU \#1\
${alignr}${freq_g 1}GHz
${cpugraph cpu1 60,300}

${color5}CPU \#2\
${alignr}${freq_g 2}GHz
${cpugraph cpu2 60,300}

${color2}CPU \#3\
${alignr}${freq_g 3}GHz
${cpugraph cpu3 60,300}

${color4}CPU \#4\
${alignr}${freq_g 4}GHz
${cpugraph cpu4 60,300}

# LOAD GRAPH
${color6}SYSTEM LOAD AVERAGE
${color3}${loadgraph 60,300}

# TOP CPU
${color6}TOP CPU\
${alignr}${color0}PID | NAME | CPU
${color4}${top pid 1}${goto 65}${color6}${top name 1}${alignr}${color2}${top cpu 1}%
${color4}${top pid 2}${goto 65}${color6}${top name 2}${alignr}${color2}${top cpu 2}%
${color4}${top pid 3}${goto 65}${color6}${top name 3}${alignr}${color2}${top cpu 3}%
${color4}${top pid 4}${goto 65}${color6}${top name 4}${alignr}${color2}${top cpu 4}%
${color4}${top pid 5}${goto 65}${color6}${top name 5}${alignr}${color2}${top cpu 5}%
${color4}${top pid 6}${goto 65}${color6}${top name 6}${alignr}${color2}${top cpu 6}%
${color4}${top pid 7}${goto 65}${color6}${top name 7}${alignr}${color2}${top cpu 7}%
${color4}${top pid 8}${goto 65}${color6}${top name 8}${alignr}${color2}${top cpu 8}%
${color4}${top pid 9}${goto 65}${color6}${top name 9}${alignr}${color2}${top cpu 9}%
${color4}${top pid 10}${goto 65}${color6}${top name 10}${alignr}${color2}${top cpu 10}%

]];
