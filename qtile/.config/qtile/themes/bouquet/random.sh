#!/usr/bin/env bash

## Copyright (C) 2020-2024 Aditya Shakya <adi1090x@gmail.com>
##
## Apply Random Theme With Pywal

## Theme ------------------------------------
TDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
THEME="${TDIR##*/}"

# Set you wallpaper directory here.
WALLDIR="`xdg-user-dir PICTURES`/wallpapers"
WALFILE="$HOME/.cache/wal/colors.sh"

## Directories ------------------------------
PATH_CONF="$HOME/.config"
PATH_QTILE="$PATH_CONF/qtile"
PATH_TERM="$PATH_QTILE/alacritty"
PATH_PBAR="$PATH_QTILE/themes/$THEME/polybar"
PATH_ROFI="$PATH_QTILE/themes/$THEME/rofi"

## Pywal ------------------------------------
check_wallpaper() {
	if [[ -d "$WALLDIR" ]]; then
		WFILES="`ls --format=single-column $WALLDIR | wc -l`"
		if [[ "$WFILES" == 0 ]]; then
			dunstify -u normal -h string:x-dunst-stack-tag:noimage -i /usr/share/archcraft/icons/dunst/picture.png "There are no wallpapers in : $WALLDIR"
			exit
		fi
	else
		mkdir -p "$WALLDIR"
		dunstify -u normal -h string:x-dunst-stack-tag:noimage -i /usr/share/archcraft/icons/dunst/picture.png "Put some wallpapers in : $WALLDIR"
		exit
	fi
}

generate_colors() {	
	check_wallpaper
	if [[ `which wal` ]]; then
		dunstify -t 50000 -h string:x-dunst-stack-tag:runpywal -i /usr/share/archcraft/icons/dunst/hourglass.png "Generating Colorscheme. Please wait..."
		wal -q -n -s -t -e -i "$WALLDIR"
		if [[ "$?" != 0 ]]; then
			dunstify -u normal -h string:x-dunst-stack-tag:runpywal -i /usr/share/archcraft/icons/dunst/palette.png "Failed to generate colorscheme."
			exit
		fi
	else
		dunstify -u normal -h string:x-dunst-stack-tag:runpywal -i /usr/share/archcraft/icons/dunst/palette.png "'pywal' is not installed."
		exit
	fi
}

generate_colors
source "$WALFILE"
altbackground="`pastel color $background | pastel lighten 0.03 | pastel format hex`"
altforeground="`pastel color $foreground | pastel darken 0.30 | pastel format hex`"
accent="$color3"

## Wallpaper ---------------------------------
apply_wallpaper() {
	sed -i -e "s#WALLPAPER=.*#WALLPAPER='$wallpaper'#g" ${PATH_QTILE}/themes/wallpaper.sh

	# Apply Wallpaper
	bash ${PATH_QTILE}/themes/wallpaper.sh
}

## Polybar -----------------------------------
apply_polybar() {
	# rewrite colors file
	cat > ${PATH_PBAR}/colors.ini <<- EOF
		[color]
		
		BACKGROUND = ${background}
		FOREGROUND = ${foreground}
		ALTBACKGROUND = ${altbackground}
		ALTFOREGROUND = ${altforeground}
		ACCENT = ${accent}
		
		BLACK = ${color0}
		RED = ${color1}
		GREEN = ${color2}
		YELLOW = ${color3}
		BLUE = ${color4}
		MAGENTA = ${color5}
		CYAN = ${color6}
		WHITE = ${color7}
		ALTBLACK = ${color8}
		ALTRED = ${color9}
		ALTGREEN = ${color10}
		ALTYELLOW = ${color11}
		ALTBLUE = ${color12}
		ALTMAGENTA = ${color13}
		ALTCYAN = ${color14}
		ALTWHITE = ${color15}
	EOF

	# Restart Polybar
	bash ${PATH_QTILE}/themes/polybar.sh
}

# Rofi --------------------------------------
apply_rofi() {
	# rewrite colors file
	cat > ${PATH_ROFI}/shared/colors.rasi <<- EOF
		* {
		    background:     ${background};
		    background-alt: ${altbackground};
		    foreground:     ${foreground};
		    selected:       ${accent};
		    active:         ${color2};
		    urgent:         ${color1};
		}
	EOF
}

# Terminal ----------------------------------
apply_terminal() {
	if [[ -f "$PATH_TERM/colors.toml" ]]; then
		# alacritty : colors
		cat > ${PATH_TERM}/colors.toml <<- _EOF_
			## Colors configuration
			[colors.primary]
			background = "${background}"
			foreground = "${foreground}"
			
			[colors.normal]
			black   = "${color0}"
			red     = "${color1}"
			green   = "${color2}"
			yellow  = "${color3}"
			blue    = "${color4}"
			magenta = "${color5}"
			cyan    = "${color6}"
			white   = "${color7}"
			
			[colors.bright]
			black   = "${color8}"
			red     = "${color9}"
			green   = "${color10}"
			yellow  = "${color11}"
			blue    = "${color12}"
			magenta = "${color13}"
			cyan    = "${color14}"
			white   = "${color15}"
		_EOF_
	fi

	if [[ -f "$PATH_QTILE/kitty/colors.conf" ]]; then
		# kitty : colors
		cat > ${PATH_QTILE}/kitty/colors.conf <<- _EOF_
			## Colors configuration
			background ${background}
			foreground ${foreground}
			selection_background ${foreground}
			selection_foreground ${background}
			cursor ${foreground}
			
			color0 ${color0}
			color8 ${color8}
			color1 ${color1}
			color9 ${color9}
			color2 ${color2}
			color10 ${color10}
			color3 ${color3}
			color11 ${color11}
			color4 ${color4}
			color12 ${color12}
			color5 ${color5}
			color13 ${color13}
			color6 ${color6}
			color14 ${color14}
			color7 ${color7}
			color15 ${color15}
		_EOF_

		# reload kitty config
		kill -SIGUSR1 $(pidof kitty)
	fi
}

# Dunst -------------------------------------
apply_dunst() {
	# modify colors
	sed -i '/urgency_low/Q' ${PATH_QTILE}/dunstrc
	cat >> ${PATH_QTILE}/dunstrc <<- _EOF_
		[urgency_low]
		timeout = 2
		background = "${background}"
		foreground = "${foreground}"
		frame_color = "${accent}"

		[urgency_normal]
		timeout = 5
		background = "${background}"
		foreground = "${foreground}"
		frame_color = "${accent}"

		[urgency_critical]
		timeout = 0
		background = "${background}"
		foreground = "${color1}"
		frame_color = "${color1}"
	_EOF_

	# Restart Dunst
	bash ${PATH_QTILE}/scripts/qtile_dunst
}

# Qtile -------------------------------------
apply_qtile() {
	# modify i3theme file
	sed -i ${PATH_QTILE}/config.py \
		-e "s/var_bg_color = .*/var_bg_color = '$background'/g" \
		-e "s/var_active_bg_color = .*/var_active_bg_color = '$accent'/g" \
		-e "s/var_active_fg_color = .*/var_active_fg_color = '$foreground'/g" \
		-e "s/var_inactive_bg_color = .*/var_inactive_bg_color = '$altbackground'/g" \
		-e "s/var_inactive_fg_color = .*/var_inactive_fg_color = '$foreground'/g" \
		-e "s/var_urgent_bg_color = .*/var_urgent_bg_color = '$color1'/g" \
		-e "s/var_urgent_fg_color = .*/var_urgent_fg_color = '$foreground'/g" \
		-e "s/var_section_fg_color = .*/var_section_fg_color = '$color3'/g" \
		-e "s/var_active_color = .*/var_active_color = '$accent'/g" \
		-e "s/var_normal_color = .*/var_normal_color = '$altbackground'/g"

	# restart i3wm
	qtile cmd-obj -o cmd -f reload_config
}

## Execute Script ---------------------------
apply_wallpaper
apply_polybar
apply_rofi
apply_terminal
apply_dunst
apply_qtile
