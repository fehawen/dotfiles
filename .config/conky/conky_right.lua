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
	minimum_width= 350,
	maximum_width= 350,
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

${color4}${hr}

# NETWORK
${color6}NETWORK STATUS
${color4}MODE\
${alignr}${color4}${wireless_mode wlp2s0}
${color4}ESSID\
${alignr}${if_match "${wireless_essid wlp2s0}"=="off/any"}${color1}disconnected${else}${color6}${wireless_essid wlp2s0}${endif}
${color4}GATEWAY\
${alignr}${color4}${gw_iface}
${color4}GATEWAY IP\
${alignr}${color4}${gw_ip}
${color4}LOCAL IP\
${alignr}${color2}${addrs wlp2s0}
${color4}PUBLIC IP\
${alignr}${color6}${curl ipinfo.io/ip 1}
${color4}ACCESS POINT\
${alignr}${color4}${wireless_ap wlp2s0}

${color4}${hr}

${color6}NETWORK TRAFFIC
${color4}DOWN\
${alignr}${color2}${downspeedf wlp2s0} KiB/s (${totaldown wlp2s0})
${color4}UP\
${alignr}${color2}${upspeedf wlp2s0} KiB/s (${totalup wlp2s0})

${color4}${hr}

# CPU USAGE
${color6}CPU USAGE
${color4}PERCENTAGE\
${alignr}${color5}${cpu}%
${color4}PROCESSES\
${alignr}${color5}${processes}

${color4}${hr}

# CPU FREQUENCY
${color6}CPU FREQUENCY
${color4}CPU \#1\
${alignr}${color2}${freq_g 1}GHz
${color4}CPU \#2\
${alignr}${color2}${freq_g 2}GHz
${color4}CPU \#3\
${alignr}${color2}${freq_g 3}GHz
${color4}CPU \#4\
${alignr}${color2}${freq_g 4}GHz

${color4}${hr}

# CPU GRAPHS
${color6}CPU LOAD

${color2}CPU \#1\
${goto 175}${color5}CPU \#2
${cpugraph cpu1 50,165 4C626A 855959 -t}\
${goto 175}${cpugraph cpu2 50,175 5E7A85 855959 -t}

${color6}CPU \#3\
${goto 175}${color4}CPU \#4
${cpugraph cpu3 50,165 72949F 855959 -t}\
${goto 175}${cpugraph cpu4 50,175 3E5661 855959 -t}

# LOAD GRAPH
${color6}SYSTEM LOAD AVERAGE
${loadgraph 50,350 4C626A 855959 -t}

# TOP CPU
${color6}TOP CPU\
${alignr}${color0}PID | NAME | CPU
${color4}${top pid 1}${goto 70}${color6}${top name 1}${alignr}${color2}${top cpu 1}%
${color4}${top pid 2}${goto 70}${color6}${top name 2}${alignr}${color2}${top cpu 2}%
${color4}${top pid 3}${goto 70}${color6}${top name 3}${alignr}${color2}${top cpu 3}%
${color4}${top pid 4}${goto 70}${color6}${top name 4}${alignr}${color2}${top cpu 4}%
${color4}${top pid 5}${goto 70}${color6}${top name 5}${alignr}${color2}${top cpu 5}%
${color4}${top pid 6}${goto 70}${color6}${top name 6}${alignr}${color2}${top cpu 6}%
${color4}${top pid 7}${goto 70}${color6}${top name 7}${alignr}${color2}${top cpu 7}%
${color4}${top pid 8}${goto 70}${color6}${top name 8}${alignr}${color2}${top cpu 8}%
${color4}${top pid 9}${goto 70}${color6}${top name 9}${alignr}${color2}${top cpu 9}%
${color4}${top pid 10}${goto 70}${color6}${top name 10}${alignr}${color2}${top cpu 10}%

]];
