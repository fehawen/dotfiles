conky.config = {
	alignment = 'top_right',
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

# TIME
${color}${alignc}${font Roboto Mono:size=24}${time %H:%M:%S}${font}

${color0}${hr}

# NETWORK
${font2}${color1}NETWORK STATUS${font}
${color}GATEWAY\
${alignr}${color6}${gw_iface}
${color}GATEWAY IP\
${alignr}${color5}${gw_ip}
${color}MODE\
${alignr}${color4}${wireless_mode wlp2s0}

${color}ACCESS POINT\
${alignr}${color3}${wireless_ap wlp2s0}
${color}ESSID\
${alignr}${if_match "${wireless_essid wlp2s0}"=="off/any"}${color1}disconnected${else}${color2}${wireless_essid wlp2s0}${endif}

${color}PUBLIC IP\
${alignr}${color6}${execi 60 curl ipinfo.io/ip}
${color}LOCAL IP\
${alignr}${color4}${addrs wlp2s0}

${color0}${hr}

${font2}${color1}NETWORK TRAFFIC${font}
${color}DOWN\
${alignr}${color6}${downspeedf wlp2s0} KiB/s (${totaldown wlp2s0})
${color}UP\
${alignr}${color6}${upspeedf wlp2s0} KiB/s (${totalup wlp2s0})

${color0}${hr}

# CPU USAGE
${font2}${color1}CPU USAGE${font}
${color}PERCENTAGE\
${alignr}${color3}${cpu}%
${color}PROCESSES\
${alignr}${color4}${processes}

${color0}${hr}

# CPU GRAPHS
${font2}${color1}LOAD\
${alignr}FREQUENCY${font}

${color6}CPU \#1\
${alignr}${freq_g 1}GHz
${cpugraph cpu1 50,300}

${color4}CPU \#2\
${alignr}${freq_g 2}GHz
${cpugraph cpu2 50,300}

${color5}CPU \#3\
${alignr}${freq_g 3}GHz
${cpugraph cpu3 50,300}

${color3}CPU \#4\
${alignr}${freq_g 4}GHz
${cpugraph cpu4 50,300}

# LOAD GRAPH
${color1}SYSTEM LOAD AVERAGE
${loadgraph 60,400}

# TOP CPU
${font2}${color1}TOP CPU\
${alignr}${color0}PID | NAME | CPU${font}
${color}${top pid 1}${goto 65}${color4}${top name 1}${alignr}${color5}${top cpu 1}%
${color}${top pid 2}${goto 65}${color4}${top name 2}${alignr}${color5}${top cpu 2}%
${color}${top pid 3}${goto 65}${color4}${top name 3}${alignr}${color5}${top cpu 3}%
${color}${top pid 4}${goto 65}${color4}${top name 4}${alignr}${color5}${top cpu 4}%
${color}${top pid 5}${goto 65}${color4}${top name 5}${alignr}${color5}${top cpu 5}%
${color}${top pid 6}${goto 65}${color4}${top name 6}${alignr}${color5}${top cpu 6}%
${color}${top pid 7}${goto 65}${color4}${top name 7}${alignr}${color5}${top cpu 7}%
${color}${top pid 8}${goto 65}${color4}${top name 8}${alignr}${color5}${top cpu 8}%
${color}${top pid 9}${goto 65}${color4}${top name 9}${alignr}${color5}${top cpu 9}%
${color}${top pid 10}${goto 65}${color4}${top name 10}${alignr}${color5}${top cpu 10}%

]];
