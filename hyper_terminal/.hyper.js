// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
	config: {
		// choose either `'stable'` for receiving highly polished,
		// or `'canary'` for less polished but more frequent updates
		updateChannel: 'stable',

		// default font size in pixels for all tabs
		fontSize: 14,

		// font family with optional fallbacks
		fontFamily: 'Fira Code',

		// default font weight: 'normal' or 'bold'
		fontWeight: 'normal',

		// font weight for bold characters: 'normal' or 'bold'
		fontWeightBold: 'bold',

		// line height as a relative unit
		lineHeight: 1,

		// letter spacing as a relative unit
		letterSpacing: 0,

		// terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
		cursorColor: '#FF85FF',

		// terminal text color under BLOCK cursor
		cursorAccentColor: '#FFFFFF',

		// `'BEAM'` for |, `'UNDERLINE'` for _, `'BLOCK'` for █
		cursorShape: 'UNDERLINE',

		// set to `true` (without backticks and without quotes) for blinking cursor
		cursorBlink: true,

		// color of the text
		foregroundColor: '#FFFFFF',

		// terminal background color
		// opacity is only supported on macOS
		backgroundColor: '#292D3E',

		// terminal selection color
		selectionColor: 'rgba(255, 133, 255, 0.35)',

		// border color (window, tabs)
		borderColor: '#1F222E',

		// custom CSS to embed in the main window
		css: '',

		// custom CSS to embed in the terminal window
		termCSS: '',

		// if you're using a Linux setup which show native menus, set to false
		// default: `true` on Linux, `true` on Windows, ignored on macOS
		showHamburgerMenu: false,

		// set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
		// additionally, set to `'left'` if you want them on the left, like in Ubuntu
		// default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
		showWindowControls: false,

		// custom padding (CSS format, i.e.: `top right bottom left`)
		padding: '12px 20px',

		// the full list. if you're going to provide the full color palette,
		// including the 6 x 6 color cubes and the grayscale map, just provide
		// an array here instead of a color map object
		colors: {
			black: '#929292',
			red: '#FF7E79',
			green: '#73FA79',
			yellow: '#FFFC79',
			blue: '#76D6FF',
			magenta: '#FF85FF',
			cyan: '#73FDFF',
			white: '#C7C7C7',
			lightBlack: '#686868',
			lightRed: '#FF7E79',
			lightGreen: '#73FA79',
			lightYellow: '#FFFC79',
			lightBlue: '#76D6FF',
			lightMagenta: '#FF85FF',
			lightCyan: '#73FDFF',
			lightWhite: '#FFFFFF',
		},

		// the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
		// if left empty, your system's login shell will be used by default
		//
		// Windows
		// - Make sure to use a full path if the binary name doesn't work
		// - Remove `--login` in shellArgs
		//
		// Bash on Windows
		// - Example: `C:\\Windows\\System32\\bash.exe`
		//
		// PowerShell on Windows
		// - Example: `C:\\WINDOWS\\System32\\WindowsPowerShell\\v1.0\\powershell.exe`
		shell: '',

		// for setting shell arguments (i.e. for using interactive shellArgs: `['-i']`)
		// by default `['--login']` will be used
		shellArgs: ['--login'],

		// for environment variables
		env: {},

		// set to `false` for no bell
		bell: false,

		// if `true` (without backticks and without quotes), selected text will automatically be copied to the clipboard
		copyOnSelect: false,

		// if `true` (without backticks and without quotes), hyper will be set as the default protocol client for SSH
		defaultSSHApp: true,

		// if `true` (without backticks and without quotes), on right click selected text will be copied or pasted if no
		// selection is present (`true` by default on Windows and disables the context menu feature)
		// quickEdit: true,

		// URL to custom bell
		// bellSoundURL: 'http://example.com/bell.mp3',

		// for advanced config flags please refer to https://hyper.is/#cfg
	},

	// a list of plugins to fetch and install from npm
	// format: [@org/]project[#version]
	// examples:
	//   `hyperpower`
	//   `@company/project`
	//   `project#1.0.1`
	plugins: [],

	// in development, you can create a directory under
	// `~/.hyper_plugins/local/` and include it here
	// to load it and avoid it being `npm install`ed
	localPlugins: [],

	keymaps: {
		// Example
		// 'window:devtools': 'cmd+alt+o',
	},
};
