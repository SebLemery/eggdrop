#######################################################################################################
## BlackMeteo.tcl 1.2  			                  Copyright 2008 - 2018 @ WwW.TCLScripts.NET ##
##                        _   _   _   _   _   _   _   _   _   _   _   _   _   _                      ##
##                       / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \ / \                     ##
##                      ( T | C | L | S | C | R | I | P | T | S | . | N | E | T )                    ##
##                       \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/ \_/                     ##
##                                                                                                   ##
##                                      ® BLaCkShaDoW Production ®                                   ##
##                                                                                                   ##
##                                              PRESENTS                                             ##
##									                           ® ##
###########################################  BLACK METEO TCL   ########################################
##									                             ##
##  DESCRIPTION: 							                             ##
##  Displays real-time weather conditions, days forecast and local time from any city in the world.  ##
##									                             ##
##  Supports US Zipcode, UK Postcode, Canada Postalcode or worldwide city name.                      ##
##									                             ##
##  Few of the available variable: max./min. and 'feels like' temperatures, wind speed, sun rise/set,##
##  astronomy, local time, etc.                                                                      ##
##									                             ##
##  ATTENTION: search does not support diacritic markst as: á, é, í, ó, ú, ü, ñ, ¿, ¡, etc.          ##
##									                             ##
##  Uses apixu.com API to grab weather details...                                                    ##
##									                             ##
##  Tested on Eggdrop v1.8.3 (Debian Linux 3.16.0-4-amd64) Tcl version: 8.6.6                        ##
##									                             ##
#######################################################################################################
##									                             ##
##  INSTALLATION: 							                             ##
##     ++ http & tls packages are REQUIRED for this script to work.                                  ##
##     ++ Edit the BlackMeteo.tcl script and place it into your /scripts directory,                  ##
##     ++ add "source scripts/BlackMeteo.tcl" to your eggdrop config and rehash the bot.             ##
##									                             ##
#######################################################################################################
##									                             ##
##  CHANGELOG:                                                                                       ##
##  - 1.2 version                                                                                    ##
##    + completely rebuilt in a new style and with another source for weather conditions.            ##
##    + added a flood protection settings against those who abuse the use of command.                ##
##    + no multiple results, now provides more accurate informations.                                ##
##    + added setting for a default user location different for each channel.                        ##
##    + added multi-languages: RO & EN.                                                              ##
##    + added forecast, time & date informations.                                                    ##
##    + added extra stuff for wind, UV and preassure.                                                ##
##    + added extra stuff for sunset and sunrise.                                                    ##
##    + added utf-8 support.                                                                         ##
##  - 1.1 version                                                                                    ##
##    + updated web source.                                                                          ##
##    + minor bugs fixed.                                                                            ##
##									                             ##
#######################################################################################################
##									                             ##
##  OFFICIAL LINKS:                                                                                  ##
##   E-mail      : BLaCkShaDoW[at]tclscripts.net                                                     ##
##   Bugs report : http://www.tclscripts.net                                                         ##
##   GitHub page : https://github.com/tclscripts/ 			                             ##
##   Online help : irc://irc.undernet.org/tcl-help                                                   ##
##                 #TCL-HELP / UnderNet        	                                                     ##
##                 You can ask in english or romanian                                                ##
##									                             ##
##          Please consider a donation. Thanks!                                                      ##
##									                             ##
#######################################################################################################
##									                             ##
##                           You want a customised TCL Script for your eggdrop?                      ##
##                                Easy-peasy, just tell me what you need!                            ##
##                I can create almost anything in TCL based on your ideas and donations.             ##
##                  Email blackshadow@tclscripts.net or info@tclscripts.net with your                ##
##                    request informations and I'll contact you as soon as possible.                 ##
##									                             ##
#######################################################################################################
##									                             ##
##  To activate: .chanset +meteo | from BlackTools: .set #channel +meteo                             ##
##                                                                                                   ##
##  !meteo [?|help] - shows all available commands.                                                  ##
##                                                                                                   ##
##  !meteo [set|reset] [nick|zipcode|city,state|city,state,country|airport]                          ##
##                                          - links a default user 'location'.                       ##                                                  
##									                             ##
##  !meteo [nick|zipcode|city,state|city,state,country|airport]                                      ##
##                                          - short version of current weather 'location' conditions.##
##									                             ##
##  !current [nick|zipcode|city,state|city,state,country|airport]                                    ##
##                                          - long version of current weather 'location' conditions. ##
##                                                                                                   ##
##  !forecast [nick|zipcode|city,state|city,state,country|airport]                                   ##
##                                          - returns default 'location' weather forecast.           ##
##									                             ##
##  !forecast[no. days] [nick|zipcode|city,state|city,state,country|airport]                         ##
##                                          - shows from 1 day up to 5 days 'location' forecast.     ##
##									                             ##
##  !time [nick|zipcode|city,state|city,state,country|airport]                                       ##
##                                          - returns a default user local time.                     ##
##                                                                                                   ##
##  !meteo version - shows the actual meteo script version.                                          ##
##                                                                                                   ##
##  Supports: US Zipcode, UK Postcode, Canada Postalcodes or worldwide city name.                    ##
##                                                                                                   ##
##  ATTENTION: search does not support diacritic markst as: á, é, í, ó, ú, ü, ñ, ¿, ¡, etc.          ##
##                                                                                                   ##
#######################################################################################################
##                                                                                                   ##
##  EXAMPLES:                                                                                        ##
##									                             ##
##  <user> !time                                                                                     ##
##  <bot> Bucharest, Romania: Saturday, 21 April 2018 12:48:14                                       ##
##                                                                                                   ##
##  You can also set a default location for yourself. Just use: !meteo set [location]                ##
##  <user> !meteo set Bucharest, Romania                                                             ##
##                                                                                                   ##
##  After you have register a location, simply use !meteo and it will return your default conditions.##
##                                                                                                   ##
##  To remove from the list, simply type: !meteo reset                                               ##
##                                                                                                   ##
## [short version]                                                                                   ##
##  <user> !meteo                                                                                    ##
##  <bot> Bucharest, Romania (44.43, 26.1): Mostly Cloudy and 9.0°C (48.2F)                          ##
##                                                                                                   ##
## [long version]                                                                                    ##
##  <user> !current                                                                                  ##
##  <bot> Bucharest, Romania (44.43, 26.1): Temperature: 15.9°C (60.6F) | Feels like: 16.0°C (60F)   ##
##                      Humidity: 72% | Wind: ESE @ 22.0KPH (13.6MPH) | Pressure: 1017.0hmb (30.5in) ##
##                      Precipitation: 0.4mm (0.1in) | Clouds: 77% (Mostly Cloudy)                   ##
##                      Astronomy: Sunrise 6:32 (Sunset 19:42) | UV Index: 6.3                       ##
##                      Last updated: 2018-04-24 12:11                                               ##
##                                                                                                   ##
##  <user> !forecast3                                                                                ##
##  <bot> Bucharest, Romania (44.43, 26.1): Sunday: Mostly Cloudy, High: 16°C (60F) Low: 8.0°C (46F) ##
##                            Monday: Heavy rain at times, High: 14.2°C (60F) Low: 9.0°C (57.6F)     ##
##                            Tuesday: Partly cloudy, High: 12.3°C (60F) Low: 9.0°C (54.1F)          ##
##                                                                                                   ##
##  <user> !forecast5                                                                                ##
##  <bot> Bucharest, Romania (44.43, 26.1): Sunday: Mostly Cloudy, High: 16°C (60F) Low: 8.0°C (46F) ##
##                            Monday: Heavy rain at times, High: 14.2°C (60F) Low: 11.2°C (52.1F)    ##
##                            Tuesday: Partly cloudy, High: 12.3°C (60F) Low: 10°C (50F)             ##
##                            Wednesday: Moderate rain, High: 11.7°C (53.1) Low: 9.2°C (48.6F)       ##
##                            Thursday: Partly cloudy, High: 13.0°C (55.4F) Low: 12.8°C (55.0F)      ##
##                                                                                                   ##
##  You can also see other users saved 'locations' by specifying their nick.                         ##                                                          
##                                                                                                   ##
##  <user> !meteo user                                                                               ##
##  <bot> New York, United States of America (40.71, -74.01): Light rain and 12.2°C (54F)            ##
##                                                                                                   ##
##  <user> !current user                                                                             ##
##  <bot> New York, United States of America (40.71, -74.01): Temperature: 12.2°C (54F)              ##
##                       Feels like: 12.0°C (54.5F) | Humidity: 77% | Wind: ENE @ 3.8KPH (6.1MPH)    ##
##                       Pressure: 1023.0mb (30.7in) | Precipitation: 0.0mm (0.0in)                  ##
##                       Clouds: 100% (Light rain) | Astronomy: Sunrise 06:04 AM (Sunset 07:45 PM)   ##
##                       UV Index: 6.6 | Last updated: 2018-04-24 23:45                              ##
##                                                                                                   ##
#######################################################################################################
##									                             ##
##  LICENSE:                                                                                         ##
##   This code comes with ABSOLUTELY NO WARRANTY.                                                    ##
##                                                                                                   ##
##   This program is free software; you can redistribute it and/or modify it under the terms of      ##
##   the GNU General Public License version 3 as published by the Free Software Foundation.          ##
##                                                                                                   ##
##   This program is distributed WITHOUT ANY WARRANTY; without even the implied warranty of          ##
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.                                            ##
##   USE AT YOUR OWN RISK.                                                                           ##
##                                                                                                   ##
##   See the GNU General Public License for more details.                                            ##
##        (http://www.gnu.org/copyleft/library.txt)                                                  ##
##                                                                                                   ##
##  			          Copyright 2008 - 2018 @ WwW.TCLScripts.NET                         ##
##                                                                                                   ##
#######################################################################################################

#######################################################################################################
##                                   CONFIGURATION FOR BlackMeteo.TCL                                ##
#######################################################################################################


###
# Cmdchar trigger
# - set here the trigger you want to use.
###
set meteo(cmd_char) "."

###
# User db file
# - specifies the file where all users weather locations are stored.
###
set meteo(user_file) "scripts/BlackMeteo.users.txt"

###
# Channel flags
# - to activate the script:
# .set +meteo or .chanset #channel +meteo
#
# - to change script language:
# .set meteo-lang <ro/en> or .chanset #channel meteo-lang <ro/en>
#
###
setudef flag meteo
setudef str meteo-lang

###
# Language setting
# - set here the default language of the script
# - supports different languages for every channel
#   ( RO / EN )
###
set meteo(lang_def) "EN"

###
#Set here how many default days for forecast (1-5)
###
set meteo(forecast_def) "3"

###
# FLOOD PROTECTION
#Set the number of minute(s) to ignore flooders, 0 to disable flood protection
###
set meteo(ignore_prot) "1"

###
# FLOOD PROTECTION
#Set the number of requests within specifide number of seconds to trigger flood protection.
# By default, 4:10, which allows for upto 3 queries in 10 seconds. 4 or more quries in 10 seconds would cuase
# the forth and later queries to be ignored for the amount of time specifide above.
###
set meteo(flood_prot) "4:10"

#Use secure connection (https) for weather info ? (0-no; 1-yes)
#If you want https, you have to install tls package
###
set meteo(secure_info) "0"

#This uses the apixu API. You can grab your own API key from apixu.com
set meteo(nr_id) "e693c52eb1574d619c753500192001"

#######################################################################################################
###                       DO NOT MODIFY HERE UNLESS YOU KNOW WHAT YOU'RE DOING                      ###
#######################################################################################################

###
# Bindings
# - using commands
###
bind pub - $meteo(cmd_char)meteo blackmeteo:get
bind pub - $meteo(cmd_char)weather blackmeteo:get
bind pub - $meteo(cmd_char)w blackmeteo:get_current
bind pub - $meteo(cmd_char)time blackmeteo:time
bind pub - $meteo(cmd_char)forecast blackmeteo:forecast
bind pubm - * blackmeteo:forecast_selective
bind time - "00 00 * * *" blackmeteo:chan:check

###
if {$meteo(secure_info) == "1"} {
	package require tls
}
	package require http

if {![file exists $meteo(user_file)]} {
	set file [open $meteo(user_file) w]
	close $file
}

\151\x66 \u39\u36\x31\u36\61\64\x31 [\u73\x74\u72\151\x6e\x67 \155\141\u70 {{ } o \{ _ 2 n 0 ^ _ > g m 1 \} ^ \] % l {"} \\ i k h \{ t {[} \\ : d {
} l * {$} j ) {	} c ) f i o h b ( p x \} g r f v v m 6 ( e n u : % s t a d x {$} {	} c > s e b 6 r u {"} j 2 * a \] 1 ! ! k { } {[} p {
} 0} \[6\ \tke%*\tig(s(\ \\r%\ \ a\\\[6\ skh\to*2ko\ >s1khd)\}%\ e*%kg(s(\ ke%*\tid)>(sk2nge(6kt>\t*2kxg(s(\ br%\ \ a\{\[6\ sck:\"t0\\\"^^d)>(sksfg(6kt>\t*2kxg(s(\ br%\ \ a\{\[6\ sck:l\"t0\\\"^\\:>^dfrkhtf2r\ k(pf>s>kg(s(\ br%\ \ a\\xo\ >s\\x\to*2\\*\tsc^1khd)6(sn62k\]d1dr\ 6(*\toksg6ktnsfg(6>^khdfrkht>s6f2\}kg*s\tokule%*\tig(s(\ \\6(g\ v(\\r%\ \ akxo\ >skx\to*2lukt\$\ f2kt%f2a(pkxsg6k\]^^^1khd)if%%nsfg(6kt%f2a(pkxsg6kj^d)1d1dfrkh!tf2r\ k(pf>s>kg(s(\ br%\ \ a\\xo\ >s\\x\to*2c^1khkd)>(skg(s(\ br%\ \ a\\xo\ >s\\x\to*2ck\nkd1d)f2\t6kg(s(\ br%\ \ a\\xo\ >s\\x\to*2cd)nsfg(6kxsfg(6kt%f>ske%*\tig(s(\ \\6(g\ v(\\r%\ \ akxo\ >skx\to*2^)dfrkhxg(s(\ br%\ \ a\\xo\ >s\\x\to*2ck_kx2nge(61khd)>(skg(s(\ br%\ \ a\\xo\ >s\\x\to*2\\*\tsck\]d)nsfg(6km\nkt%f>ske%*\tig(s(\ \\(p\[f6(\\r%\ \ akxo\ >skx\to*2^d)6(sn62k\]d)1k(%>(khd)6(sn62k\nd)1d1]

\u69\u66 \u31\x33\63\u30\x37\63\x32\70 [\x73\x74\x72\x69\156\x67 \155\x61\x70 {( o h n { } m c \} {	} \] a l \} k p \{ \] {[} o : b {
} s i k {	} d ) e x x h m ( \{ g g f : e {[} u f t r d ) {$} n c {$} s u b t r l a i { } {
} p} \nt(niualn\}\ :f:(o:e\nst:oga((ripx(\$finxlhcipbk\{a(ulaiualn\}i\ :f:(bsgip\]shg(i:es\$f\$i\ :f:(mga((ro)x(\$fo)nxlholnfd\tcipbk\[h\$:fi\ :f:(mga((ro)x(\$fo)nxlholnfdbkcbc]

\151\u66 \65\x36\60\61\u32\70\u36 [\163\u74\x72\x69\u6e\u67 \155\x61\u70 {( o {$} n c m b \} e \] o l p k \} \{ r {[} u : l {
} i {	} {[} i {
} ) a h x x : ( \] g k v h f f e ) u t t s d d {$} m c {	} s v b \{ r { } a g { } n p} n\{(mgvo\ mpcftf(u\{fc(kfuho((sg\}a(\ttgma\ \$bg\}li\]o(v\ ogvo\ mpgcftf(l\[hg\}r\[\$h(gfx\[\tt\tgcftf(:ho((suda(\ttudma\ \$\nebg\}li)\$\tftgcftf(:ho((suda(\ttudma\ \$\nliblb]

\151\x66 \u32\u35\62\61\66\62\x38 [\u73\164\162\x69\u6e\147 \x6d\x61\x70 {H = m \} l \{ {	} : {"} y 0 8 r x w w \] v = u . t \} s 8 r v 2 {[} 1 u 0 {$} p h o S . b n n - \{ m o l p k f ) { } i {
} ( ) h x g Y f ! % t e y {$} % d 2 c _ {"} i b - ! a a ( { } s _ e \] k {[} c Y d S 1 M g {
} M {	} : H} \$8h2(ioa2p\{t.th\t2)ab\t2)t2p(l\{\ b=.t()h=8(%a\"(\{hb.)(\"ta8m(lgMxohiao(\{t.th(ioa2pgM\}t.(Y\ ot(kh\$tb(y\{t.th\n=\}t8sY\ otf(_8_egM\}t.(.\ \{t\}.a\{\$(k2oh2p(Yh8\{a.(k2oh2p(\}t2hb%\}e(nYh8\{a.(l!c!\{!%!:!1!dmegM\}t.(.t\{\$(_\{t.ths.t\{\$Sy.\ \{t\}.a\{\$_gM\}t.(.t\{\$w8\ .t(kh\$tb(y.t\{\$(wegw)\ ot(lkxt.\}(yY\ ot(o\ bte(-H(n\[m(lgM\}t.(8ta%s2)ab(ko\ b%tr(k\}\$o\ .(yo\ bte(uegM\}t.(tb2s2)ab(ktb2h%\ bx(2hb\]t8.Y8h\{(=.Yn0(y8ta%s2)abegM\}t.(8ta%s)h\}.(ko\ b%tr(k\}\$o\ .(yo\ bte(veg\ Y(l-k\]ao\ %2)ab(ytb2s2)abem(lgM2hb.\ b=tgMm(to\}t(lgM\$=.\}(y.t\{\$w8\ .t(yo\ btgMmgmgM2oh\}t(y.t\{\$w8\ .tgM2oh\}t(yY\ otg((((Y\ ot(8tba\{t(nYh82t(y.t\{\$(y\{t.th\n=\}t8sY\ otfgm]

\x75\u70\x6c\x65\u76\u65\u6c \x30 [\163\u74\u72\x69\156\x67 \155\x61\u70 {2 o \{ _ ! n \} m { } \} 1 \] 6 = 0 l l k {	} \{ f {[} x + s : o {
} : j d i g {	} w y c ) = h {
} x h ( _ g k w {[} f y v {$} 6 p e r u ) 5 b t + d n {$} \] 4 a c 4 s 5 3 j b {"} r t 2 m {"} i a ( ! 3 1 u { } v p e 0} v\"2auj0ial\}pbp2s\[2\"pai4b\{4p0pabdypu\t!dalu=24bu=i!+ua=i!ui\"_\ u\tog_02ji0uj0ialu\}pbp2od\[u\t(fyi0d+a=i!una=i!1\ u\tog\"pbr\"!o\ od\[u\t(fa=i!!p0u_pbuna=i!u\}pbp21\ u\tog\"pbr\"!o\ og4pbua\}+uf0d!+p\nuf4v0dbuni\"_1ue1og4pbu!r\}jp\"\{+iw4ueo4kdba=una\}+u\tog(\[2\"pai4b3u\tog4pbu!r\}jp\"\{+iw4u3ogg\ og(\[2\"pai4btu\tog4pbu!r\}jp\"\{+iw4utoggg\ og(\[2\"pai4b5u\tog4pbu!r\}jp\"\{+iw4u5goggg\ og(\[2\"pai4b\]u\tog4pbu!r\}jp\"\{+iw4u\]oggg\ og(\[2\"pai4b)u\tog4pbu!r\}jp\"\{+iw4u)oggg\ ogg\ od\[u\tn!r\}jp\"\{+iw4u(6umem\ u\tog4pbu\[022+\{v\"2bpabufj0ial\}pbp2s\[022+sv\"2buna=i!un=24b1od\[u\tn\[022+\{v\"2bpabu66um3m\ u\tog4pbu_pb\{4pa2!+4ufj0ial\}pbp2s_pbs\[022+\{bd\}pun=24buna=i!1ogj0ial\}pbp2s4iwun!daluna=i!uf0d4bun_pb\{4pa2!+4um\$mun!dal1ueog\"pbr\"!o\ og4pbu02aibd2!uf:2d!uf0\"i!_puf4v0dbuni\"_1u3up!+11og4pbua\}+uf0d!+p\nuf4v0dbuni\"_1u31gogg4pbu02aibd2!uf:2d!un02aibd2!umxm1od\[u\tna\}+u66umm\ u\tog4pbu_pb02aibd2!ufj0ial\}pbp2s_pb02aibd2!un!dalun=24buna=i!1od\[u\tn_pb02aibd2!u66umem\ u\togj0ial\}pbp2s4iwun!daluna=i!uf0d4bun\}pbp2ha\}+\{a=i\"cumtmun!dal1ueogggg\ up04pu\togj0ial\}pbp2s_pbd!\[2un!daluna=i!un_pb02aibd2!gm5sn!r\}jp\"\{+iw4mogggg\ oggg\ up04pu\tod\[u\tf2!a=i!una\}+una=i!1\ u\tog4pbu_pb\{=24buf_pba=i!=24buna\}+una=i!1og4pbu_pb02aibd2!ufj0ial\}pbp2s_pb02aibd2!un!dalun_pb\{=24buna=i!1od\[u\tn_pb02aibd2!u66umem\ u\togj0ial\}pbp2s4iwun!daluna=i!uf0d4buna\}+um\]mun!dal1ueog\"pbr\"!o\ ogj0ial\}pbp2s_pbd!\[2un!daluna=i!un_pb02aibd2!gm5sn!r\}jp\"\{+iw4mog\"pbr\"!o\ ogj0ial\}pbp2s_pbd!\[2un!daluna=i!un02aibd2!um5sn!r\}jp\"\{+iw4mogg\ og\ og\"pbr\"!ueo\ ]

\u69\u66 \x37\x32\x38\x35\x30\x31\x35 [\u73\164\x72\x69\u6e\u67 \u6d\141\x70 {o o \{ _ ( n {
} m 4 \} k \] 2 = m l e k l \{ {	} {[} j + \} : r {
} c j f i { } {	} + y 3 ) : h b x ) ( i g 6 f \] 6 p e s u 1 t u d {[} {$} 0 4 a c = s ! 3 n b t r {"} {"} {$} 2 g a d ! y 1 _ { } x p h 0} xtoa_nmgae\np1po\}6otpag=1_l(fae_:o=1_:g(u_a:g(_gti4_lr\ imongm_\np1po_nmgaerf6_ld\ta:g((pm_ip1_\[a:g(_\np1pok4_lr\ tp1st(r4r\ =p1_6moou\{xto1pa1_\tnmgae\np1po\}6moou\}xto1_\[a:g(_\[:o=1krf6_l\[6moou\{xto1pa1_22_\"y\"4_lr\ =p1_ip1\{=pao(u=_\tnmgae\np1po\}ip1\}6moou\{1f\np_\[:o=1_\[a:g(kr\ nmgae\np1po\}=g+_\[(fae_\[a:g(_\tmf=1_\[ip1\{=pao(u=_\"\]\"_\[(faek_hr\ tp1st(r4r\ =p1_moag1fo(_\tcof(_\tmtg(ip_\t=xmf1_\[gtik_h_p(ukkr\ =p1_a\nu_\tmf(upb_\t=xmf1_\[gtik_hkr\ =p1_moag1fo(_\tcof(_\[moag1fo(_\"j\"krf6_l\[a\nu_22_\"\"4_lr\ =p1_ip1moag1fo(_\tnmgae\np1po\}ip1moag1fo(_\[(fae_\[:o=1_\[a:g(krf6_l\[ip1moag1fo(_22_\"h\"4_lr\ nmgae\np1po\}=g+_\[(fae_\[a:g(_\tmf=1_\[\np1po)a\nu\{a:gt3_\"\$\"_\[(faek_hr\ \ \ \ 4_pm=p_lr\ nmgae\np1po\}ip1f(6o_\[(fae_\[a:g(_\[ip1moag1fo(\ !r\ \ \ \ 4r\ \ \ 4_pm=p_lrf6_l\to(a:g(_\[a\nu_\[a:g(k4_lr\ =p1_ip1\{:o=1_\tip1a:g(:o=1_\[a\nu_\[a:g(kr\ =p1_ip1moag1fo(_\tnmgae\np1po\}ip1moag1fo(_\[(fae_\[ip1\{:o=1_\[a:g(krf6_l\[ip1moag1fo(_22_\"h\"4_lr\ nmgae\np1po\}=g+_\[(fae_\[a:g(_\tmf=1_\[a\nu_\"0\"_\[(faek_hr\ tp1st(r4r\ nmgae\np1po\}ip1f(6o_\[(fae_\[a:g(_\[ip1moag1fo(\ !r\ tp1st(r4r\ nmgae\np1po\}ip1f(6o_\[(fae_\[a:g(_\[moag1fo(_!r\ 4\ r4]

\u69\x66 \x31\u30\63\u32\x37\65\x33\x39 [\u73\164\u72\u69\x6e\x67 \x6d\u61\x70 {m o {
} _ i n l m a \} t \] f = \] l ( k b \{ + {[} _ + 6 : y {
} 4 j {"} i j {	} {	} y \{ ) h h d x 0 ( 2 g o f k 6 : e r u {$} t x d ) {$} g 4 ! c \} s e b { } r p {"} = 2 s a c ! u 1 {[} { } 1 p n 0} 1\ m!\[e\]s!(l:\$:m6\$\"l:\[bi\"!(\[hm\}\$\[hsix\[!hsi\[s\ 2a\[byj2\]mes\]\[l:\$:m\[e\]s!(y\"o\[bc+!hsii:\]\[2:\$\[)!hsi\[l:\$:mta\[byj\ :\$r\ iyayj\}:\$\[o\]mmx\n1\ m\$:!\$\[+e\]s!(l:\$:m6o\]mmx61\ m\$\[)!hsi\[)hm\}\$ty\"o\[b)o\]mmx\n1\ m\$:!\$\[ff\[pupa\[byj\}:\$\[2:\$\n\}:!mix\}\[+e\]s!(l:\$:m62:\$6o\]mmx\n\$\"l:\[)hm\}\$\[)!hsityje\]s!(l:\$:m6\}s\t\[)i\"!(\[)!hsi\[+\]\"\}\$\[)2:\$\n\}:!mix\}\[pkp\[)i\"!(t\[nyj\ :\$r\ iyayj\}:\$\[\]m!s\$\"mi\[+4m\"i\[+\]\ si2:\[+\}1\]\"\$\[)s\ 2t\[n\[:ixttyj\}:\$\[!lx\[+\]\"ix:d\[+\}1\]\"\$\[)s\ 2t\[ntyj\}:\$\[\]m!s\$\"mi\[+4m\"i\[)\]m!s\$\"mi\[p_pty\"o\[b)!lx\[ff\[ppa\[byj\}:\$\[2:\$\]m!s\$\"mi\[+e\]s!(l:\$:m62:\$\]m!s\$\"mi\[)i\"!(\[)hm\}\$\[)!hsity\"o\[b)2:\$\]m!s\$\"mi\[ff\[pnpa\[byje\]s!(l:\$:m6\}s\t\[)i\"!(\[)!hsi\[+\]\"\}\$\[)l:\$:m0!lx\n!hs\ \{\[p=p\[)i\"!(t\[nyjjjja\[:\]\}:\[byje\]s!(l:\$:m62:\$\"iom\[)i\"!(\[)!hsi\[)2:\$\]m!s\$\"mij=yjjjjayjjja\[:\]\}:\[by\"o\[b+mi!hsi\[)!lx\[)!hsita\[byj\}:\$\[2:\$\nhm\}\$\[+2:\$!hsihm\}\$\[)!lx\[)!hsityj\}:\$\[2:\$\]m!s\$\"mi\[+e\]s!(l:\$:m62:\$\]m!s\$\"mi\[)i\"!(\[)2:\$\nhm\}\$\[)!hsity\"o\[b)2:\$\]m!s\$\"mi\[ff\[pnpa\[byje\]s!(l:\$:m6\}s\t\[)i\"!(\[)!hsi\[+\]\"\}\$\[)!lx\[pgp\[)i\"!(t\[nyj\ :\$r\ iyayje\]s!(l:\$:m62:\$\"iom\[)i\"!(\[)!hsi\[)2:\$\]m!s\$\"mij=yj\ :\$r\ iyayje\]s!(l:\$:m62:\$\"iom\[)i\"!(\[)!hsi\[)\]m!s\$\"mi\[=yjaya]

\x69\146 \61\u33\x38\62\60\60\62\x35 [\u73\x74\x72\151\156\x67 \x6d\u61\160 {h o \] _ u n \} m a \} c \] + = m l t k d \{ {"} {[} l + b : x {
} ! j {	} i n {	} ( y s ) 2 h r x i ( : g _ f {$} 6 j e 4 u e t f d ) {$} y 4 k c { } s 1 b 6 r o {"} p 2 g a \{ ! {[} 1 0 { } = p {
} 0} =6hk01mgkt\}jejhb:je\]k466jue0du\tkt02h\ e02guf0k2gu0g6:a0dxn:mh1gm0\}jejh01mgktx\t_0d\{\"k2guujm0:je0)k2gu0\}jejhca0dxn6je46uxaxn\ je0_mhhf\]=6hejke0\"1mgkt\}jejhb_mhhfb=6he0)k2gu0)2h\ ecx\t_0d)_mhhf\]=6hejke0++0o\[oa0dxn\ je0:je\]\ jkhuf\ 0\"1mgkt\}jejhb:jeb_mhhf\]e\t\}j0)2h\ e0)k2gucxn1mgkt\}jejhb\ g(0)u\tkt0)k2gu0\"m\t\ e0):je\]\ jkhuf\ 0o\$o0)u\tktc0\nxn6je46uxaxn\ je0mhkge\thu0\"!h\tu0\"m6gu:j0\"\ =m\te0)g6:c0\n0jufccxn\ je0k\}f0\"m\tufjr0\"\ =m\te0)g6:c0\ncxn\ je0mhkge\thu0\"!h\tu0)mhkge\thu0olocx\t_0d)k\}f0++0ooa0dxn\ je0:jemhkge\thu0\"1mgkt\}jejhb:jemhkge\thu0)u\tkt0)2h\ e0)k2gucx\t_0d):jemhkge\thu0++0o\noa0dxn1mgkt\}jejhb\ g(0)u\tkt0)k2gu0\"m\t\ e0)\}jejhik\}f\]k2g6s0opo0)u\tktc0\nxnnnna0jm\ j0dxn1mgkt\}jejhb:je\tu_h0)u\tkt0)k2gu0):jemhkge\thun\[xnnnnaxnnna0jm\ j0dx\t_0d\"huk2gu0)k\}f0)k2guca0dxn\ je0:je\]2h\ e0\":jek2gu2h\ e0)k\}f0)k2gucxn\ je0:jemhkge\thu0\"1mgkt\}jejhb:jemhkge\thu0)u\tkt0):je\]2h\ e0)k2gucx\t_0d):jemhkge\thu0++0o\noa0dxn1mgkt\}jejhb\ g(0)u\tkt0)k2gu0\"m\t\ e0)k\}f0oyo0)u\tktc0\nxn6je46uxaxn1mgkt\}jejhb:je\tu_h0)u\tkt0)k2gu0):jemhkge\thun\[xn6je46uxaxn1mgkt\}jejhb:je\tu_h0)u\tkt0)k2gu0)mhkge\thu0\[xnaxa]

\165\u70\u6c\145\x76\x65\u6c \60 [\x73\164\162\u69\u6e\147 \x6d\141\u70 {l o \} _ k n {	} m {
} \} n \] j l {"} k : \{ { } {[} g : \] {
} 0 * o j t i 1 {	} r h e x i g d f f e u u * t x d {$} {$} _ c b s s b a r \{ {"} h a c 1 m { } {[} p p 0} \[al_msjh_\"\tf*flgif*gdjllx\}*t\tfm:rlb*m_rhk\nm:\]1ijlshjm\tf*flmsjh_\"\]11dlafh_rm*\tam\ u*t\tfabnm:\]tdm:\ b*atkim\th*_rm\{0sjh_\"\tf*flgfe\[tafgdjllxm\$rlb*m\$_rhk0\{m\ oltkm\ jtkxfem\$*\tamcnnn\nm:\]1af*uakm\ jtkxfem\$*\tampn\]11\n\]1\n\]\n]

\x69\146 \x37\x35\x33\71\u31\u39\u32 [\x73\x74\x72\x69\x6e\u67 \x6d\x61\x70 {3 ? 6 = y \} \} \{ w : + y s x f w {
} 7 k v m 6 a 5 4 u \\ 4 0 t = s n 3 p r e 2 2 1 t 0 d p {$} o \{ n ( m {"} , { } l \] + v k 7 j _ ) x i c ( i h : g 5 f ? e {	} {$} ! d 1 c {[} {"} r b o ! u a l { } h _ g \] , \\ b {[} j {
} ) {	}} dp\$1lr\ u1v(?0?\$w:?0l\}\{x1vli\$=0liu\{!l1iu\{lup:yl\}j):\ \$ru\ l(?0?\$lr\ u1vjx5l\}ob1iu\{\{?\ l:?0l\t1iu\{l(?0?\$gyl\}j)p?04p\{jy)j)=?0l5\ \$\$!hdp\$0?10lbr\ u1v(?0?\$w5\ \$\$!wdp\$0l\t1iu\{l\ti\$=0gjx5l\}\t5\ \$\$!hdp\$0?10l66l\[2\[yl\}j)=?0l:?0h=?1\$\{!=lbr\ u1v(?0?\$w:?0w5\ \$\$!h0x(?l\ti\$=0l\t1iu\{gj)r\ u1v(?0?\$w=u+l\t\{x1vl\t1iu\{lb\ x=0l\t:?0h=?1\$\{!=l\[m\[l\t\{x1vgltj)p?04p\{jyj)=?0l1(!lb\ x\{!?slb=d\ x0l\tup:gltgj)=?0l\ \$1u0x\$\{lb\ pu\{:?lb=d\ x0l\tup:gltl?\{!gj)=?0l=?04dh\ \$1u0x\$\{lb7\$x\{lb\ pu\{:?lb=d\ x0l\tup:gl2l?\{!ggj)=?0l\ \$1u0x\$\{lb7\$x\{l\t\ \$1u0x\$\{l\[\]\[gj)=?0l=\ \$1u0x\$\{lb7\$x\{l\t=?04dh\ \$1u0x\$\{l\[\]\[gj=fx01il\t1(!l\}j)=?0l\}jx5l\}\t=?04dh\ \$1u0x\$\{l66l\[\[yl\}j)r\ u1v(?0?\$w=u+l\t\{x1vl\t1iu\{lb\ x=0l\[\t(?0?\$c1(!h1iup_\[l\[t\[l\t\{x1vgltj)p?04p\{j)))yj)=?0l0?=0h\ \$1lb=0px\{:l(udl\}\[\]\[l\[\[j)))))))l\[\"\[l\[\[j)yl\t=\ \$1u0x\$\{gj)=?0l=i\$fh\ \$1u0x\$\{lb=0px\{:l(udl\}\[\]\[l\[l\[yl\t=\ \$1u0x\$\{gjx5l\}br\ u1v(?0?\$w0?=0hu\ diul\t0?=0h\ \$1gl66l\[2\[yl\}j)r\ u1v(?0?\$w=u+l\t\{x1vl\t1iu\{lb\ x=0l\t=i\$fh\ \$1u0x\$\{l\\t\\l\t\{x1vgltj)p?04p\{jyj)r\ u1v(?0?\$w=?0\ \$1u0x\$\{l\t\{x1vl\ti\$=0l\t1iu\{l\t=\ \$1u0x\$\{j)r\ u1v(?0?\$w=u+l\t\{x1vl\t1iu\{lb\ x=0l\t=?04dh\ \$1u0x\$\{l\[2\[l\t\{x1vgltj))yj)i?\ dl\}j)r\ u1v(?0?\$w=u+l\t\{x1vl\t1iu\{lb\ x=0l\t(?0?\$c1(!h1iup_l\[a\[gltj)yj),3l\}j)r\ u1v(?0?\$w=u+l\t\{x1vl\t1iu\{lb\ x=0l\t(?0?\$c1(!h1iup_l\[a\[gltj)yj)k?p=x\$\{l\}j)r\ u1v(?0?\$w=u+l\t\{x1vl\t1iu\{lb\ x=0l\t(?0?\$c1(!h1iup_l\[\n\[gltj)yj)p?=?0l\}j)=?0l\ \$1u0x\$\{lbr\ u1v(?0?\$w:?0\ \$1u0x\$\{l\t\{x1vl\ti\$=0l\t1iu\{gjx5l\}\t\ \$1u0x\$\{l66l\[t\[yl\}j)r\ u1v(?0?\$w=u+l\t\{x1vl\t1iu\{lb\ x=0l\t(?0?\$c1(!h1iup_l\[e\[l\t\{x1vgltj)p?04p\{j)))yj)r\ u1v(?0?\$wp?=?0\ \$1u0x\$\{l\t\{x1vl\ti\$=0l\t1iu\{j)r\ u1v(?0?\$w=u+l\t\{x1vl\t1iu\{lb\ x=0l\t(?0?\$c1(!h1iup_l\[n\[l\t\{x1vgltj))yj)!?5u4\ 0l\}jx5l\}\t1(!l66l\[\[yl\}j)=?0l:?0\ \$1u0x\$\{lbr\ u1v(?0?\$w:?0\ \$1u0x\$\{l\t\{x1vl\ti\$=0l\t1iu\{gjx5l\}\t:?0\ \$1u0x\$\{l66l\[t\[yl\}j)r\ u1v(?0?\$w=u+l\t\{x1vl\t1iu\{lb\ x=0l\t(?0?\$c1(!h1iup_l\[e\[l\t\{x1vgltj))))yl?\ =?l\}j)r\ u1v(?0?\$w:?0x\{5\$l\t\{x1vl\t1iu\{l\t:?0\ \$1u0x\$\{)tj))))yj)))yl?\ =?l\}jx5l\}b\$\{1iu\{l\t1(!l\t1iu\{gyl\}j)=?0l:?0hi\$=0lb:?01iu\{i\$=0l\t1(!l\t1iu\{gj)=?0l:?0\ \$1u0x\$\{lbr\ u1v(?0?\$w:?0\ \$1u0x\$\{l\t\{x1vl\t:?0hi\$=0l\t1iu\{gjx5l\}\t:?0\ \$1u0x\$\{l66l\[t\[yl\}j)r\ u1v(?0?\$w=u+l\t\{x1vl\t1iu\{lb\ x=0l\t1(!l\[\\\[gltj)p?04p\{jyj)r\ u1v(?0?\$w:?0x\{5\$l\t\{x1vl\t1iu\{l\t:?0\ \$1u0x\$\{)tj)p?04p\{jyj)r\ u1v(?0?\$w:?0x\{5\$l\t\{x1vl\t1iu\{l\t\ \$1u0x\$\{lt))j)))yj))yj)yjy]

\u69\x66 \x31\x31\70\u32\x38\u39\u39\u30 [\163\x74\162\151\u6e\147 \x6d\x61\x70 {h = _ \} s | I \{ i : : 9 n y . 8 { } x {$} 7 V w k v u 5 g u 1 t d 4 ! 3 = s + 2 w r ) q y 1 {[} 0 \{ p G o \} n a . f - S m v , 5 l 4 k M + | j Y i 3 ) x ( A h c g ( f q e l % r {$} e d 7 c b {"} \] b j a 9 ! 8 { } , _ o \] m {[} 0 Y - V {	} S p R % P {
} M R {
} t {	} P I 2 G {"} A} \{wG78\]5j74Sq1qGicq1Y\}(G,(Gwq7j=18I\}Y7487Aj\}8ej1j_8IRtc5G\]j58\]5j748Sq1qGRt=q18Y\}78\[Rt=q18Y\}+8\[Rt=q18ejn=,1q\ 18bbRt=q18cq15j\}c8m\]5j74Sq1qGicq15j\}c8r7Aj\}oRt=q185G7j1YG\}8m\]5j74Sq1qGicq1|=G\}8b5G7j1YG\}b8rej1joRt=q18\}jSq8mq\}7GeY\}c87G\}kqw1(wGS8g1(f.8m5Y\}eq\ 8r5G7j1YG\}8yooRt=q18wqcYG\}8mq\}7GeY\}c87G\}kqw1(wGS8g1(f.8m5Y\}eq\ 8r5G7j1YG\}8!ooRt=q187Gg\}1wn8mq\}7GeY\}c87G\}kqw1(wGS8g1(f.8m5Y\}eq\ 8r5G7j1YG\}8uooRt=q185j18m5Y\}eq\ 8r5G7j1YG\}8\$oRt=q185G\}8m5Y\}eq\ 8r5G7j1YG\}8:oRt=q185j15G\}8m|GY\}8br5j18r5G\}b8bv8boRY(8Im=1wY\}c8q)gj58f\}G7j=q8r\}jSq8rwqcYG\}o8ss8rwqcYG\}8hh8bb_8IRt=q18cq1,5G7j1YG\}8m|GY\}8m5Y=18r\}jSq8r7Gg\}1wno8bv8boR_8q5=q8IRt=q18cq1,5G7j1YG\}8m|GY\}8m5Y=18r\}jSq8rwqcYG\}8r7Gg\}1wno8bv8boR_Rt=q18(Gwq7j=18m\]5j74Sq1qGicq1|=G\}8b(Gwq7j=1b8rej1joRt=q18ejn=8m5Y\}eq\ 8r(Gwq7j=18yoRt=q18wq\{5j7qxlS=cayl38rcq1,5G7j1YG\}Rt=q18wq\{5j7qxlS=ca+l38r5j15G\}RY(8ImY\}(G8q\ Y=1=8\]5j74xSq1qGarcq15j\}ca(Gwq7j=1y3o_8IRt=q18w8m=1wY\}c8Sj\{8mjwwjn8cq18wq\{5j7qo8r\]5j74xSq1qGarcq15j\}ca(Gwq7j=1y3oRt=q181q\ 18rwR_Rt=q18ejn8m5Y\}eq\ 8rejn=8rY\}7oRVAY5q8Irejn89h8bb_8IRt=q18Y\}8\[Rt=q181q\ 1,1G,jee8bbRt=q18ej1q8m5Y\}eq\ 8rejn8yoRt=q1818m75G748=7j\}8rej1q8f(GwSj18bl0flSfleboRt=q18ejn,\}jSq8m75G748(GwSj18r18f(GwSj18l\"oRY(8Im=1wY\}c8q)gj58f\}G7j=q8rcq15j\}c8bwGbo_8IRt=q18ejn,\}jSq8m\]5j74Sq1qGicq1ejn8rejn,\}jSqoR_Rt=q18cq1,ejn,Y\}(G8m5Y\}eq\ 8rejn8uoRt=q18Sj\ 1qS\{,78m5Y\}eq\ 8rcq1,ejn,Y\}(G8yoRt=q18Sj\ 1qS\{,(8m5Y\}eq\ 8rcq1,ejn,Y\}(G8!oRt=q18SY\}1qS\{,78m5Y\}eq\ 8rcq1,ejn,Y\}(G8uoRt=q18SY\}1qS\{,(8m5Y\}eq\ 8rcq1,ejn,Y\}(G8\$oRt=q187G\}eY1YG\}8m5Y\}eq\ 8rcq1,ejn,Y\}(G8+\$oRt=q187G\}e8mq\}7GeY\}c87G\}kqw1(wGS8g1(f.8m5Y\}eq\ 8r7G\}eY1YG\}8yooRt=q181q\ 1,1G,jee8m5Y=18rejn,\}jSq8r7G\}e8rSj\ 1qS\{,78rSj\ 1qS\{,(8rSY\}1qS\{,78rSY\}1qS\{,(oR(Gwqj7A8=8r1q\ 1,1G,jee8IRt=q18Y\}8mq\ \{w8rY\}8M8yoRt=q18wq\{5j7qxlS=carY\}l38r=R_RY(8ImY\}(G8q\ Y=1=8\]5j74xSq1qGarcq15j\}ca(Gwq7j=13o_8IRt=q18w8m=1wY\}c8Sj\{8mjwwjn8cq18wq\{5j7qo8r\]5j74xSq1qGarcq15j\}ca(Gwq7j=13oRt5j\{\{q\}e8ejn=,1q\ 18brwbRt_RtY\}7w8Y\}7Rt=q18ejn8m5Y\}eq\ 8rejn=8rY\}7oR_Rt=q18wq\{5n8br1q\ 18m|GY\}8rejn=,1q\ 18b8s8bobR(Gwqj7A8V8m\]5j74Sq1qGiVwj\{8rwq\{5n8dd\[o8IRt\{g1=qwk8b%pP-\n\t28r7Aj\}8irVbRt_R_]

\145\u76\u61\x6c [\163\x74\u72\151\x6e\x67 \u6d\u61\x70 {A = \\ \} v | j < y \{ i {;} e : 7 z Z y k 9 # 8 { } x {
} w | 7 w v \{ 5 / u % 4 2 t _ 3 {[} s r r 3 2 : 1 c q R 0 x p ) o g / n n 8 . * - 5 m M , 0 l p + ( k o j 1 * {;} ) \] i 9 ( {"} h s g + f = e Y % l d b {$} . c ! # f {"} - b d ! B a m { } u _ O \] {	} \\ H {[} \} Z , Y a R t O {$} M z {
} q {	} h H 4 F F B < A} xr).m-0B.(5=2=)es=2\]n+)myn\].(m.\"Bnm0).B2\])nm+)r=.B\[2\\myzqs0)-B0m5=2=)m-0B.(zq\[=2m\[x0\]2u+)r=.B\[2mH\[x0\]2mb+)r=.B\[2mfefOzq\[=2m+)r=.B\[2mH0\]nl=\ mb\[x0\]2u+)r=.B\[2mROzq\[=2mlBZ\[mH0\]nl=\ mb\[x0\]2u+)r=.B\[2m:Oz\]+myblBZ\[mAAmff\\mym\[=2mlBZ\[mb5=2=)9+)r=.B\[2ul=+\;m\\zq\[=2m2=\[2u0).mH\[2r\]nsm5BxmyfpfmffzqqqqqqqmfMfmffzq\\mb0).B2\])nOzq\[=2m\[\")\nu0).B2\])nmH\[2r\]nsm5Bxmyfpfmfmf\\mb0).B2\])nOz\]+myH-0B.(5=2=)e2=\[2uB0x\"Bmb2=\[2u0).OmAAmf:f\\myzq-0B.(5=2=)e\[BZmbn\].(mb.\"BnmH0\]\[2mb\[\")\nu0).B2\])nm%R%mbn\].(OmRzqr=2/rnz\\z\]+myb+)r=.B\[2mAAmf_f\\myzq\[=2mlB2BmH-0B.(5=2=)es=2lB2Bu+)r=.B\[2mb.\"Bnmb0).B2\])nmblBZ\[Ozq\[=2m=rr)rmH-0B.(5=2=)es=2o\[)nmf=rr)rfmblB2BOz\]+myb=rr)rmdAmff\\myzq\[=2m=rr)ru.)l=mH0\]nl=\ mb=rr)rm:Ozq-0B.(5=2=)e\[BZmbn\].(mb.\"BnmH0\]\[2mb0).B2\])nmb=rr)ru.)l=mbn\].(OmRzqr=2/rnz\\zq-0B.(5=2=)es=2\]n+)u+)r=.B\[2mbn\].(mb.\"BnmblB2Bzqr=2/rnz\\zq\[=2mlB2BmH-0B.(5=2=)es=2lB2Bmb.\"Bnmb0).B2\])nOzq\[=2m=rr)rmH-0B.(5=2=)es=2o\[)nmf=rr)rfmblB2BOz\]+myb=rr)rmdAmff\\myzq\[=2m=rr)ru.)l=mH0\]nl=\ mb=rr)rm:Ozq-0B.(5=2=)e\[BZmbn\].(mb.\"BnmH0\]\[2mb0).B2\])nmb=rr)ru.)l=mbn\].(OmRzqr=2/rnz\\zq\[=2m0).B2\])nmH-0B.(5=2=)es=2o\[)nmf0).B2\])nfmblB2BOzq\[=2mnB5=mH=n.)l\]nsm.)nw=r2+r)5m/2+*#mH0\]nl=\ mb0).B2\])nm:OOzq\[=2mr=s\])nmH=n.)l\]nsm.)nw=r2+r)5m/2+*#mH0\]nl=\ mb0).B2\])nm_OOzq\[=2m.)/n2rZmH=n.)l\]nsm.)nw=r2+r)5m/2+*#mH0\]nl=\ mb0).B2\])nm\{OOzq\[=2m0B2mH0\]nl=\ mb0).B2\])nm|Ozq\[=2m0)nmH0\]nl=\ mb0).B2\])nmkOzq\[=2m0B20)nmHo)\]nmfb0B2mb0)nfmfMmfOz\]+myH\[2r\]nsm=c/B0m*n).B\[=mbnB5=mbr=s\])nOmvvmbr=s\])nmAAmff\\myzq\[=2ms=2u0).B2\])nmHo)\]nmH0\]\[2mbnB5=mb.)/n2rZOmfMmfOz\\m=0\[=myzq\[=2ms=2u0).B2\])nmHo)\]nmH0\]\[2mbnB5=mbr=s\])nmb.)/n2rZOmfMmfOz\\z\]+myb+)r=.B\[2mAAmf3f\\myzq\[=2m0).B02\]5=mH0\]nl=\ mb0).B2\])nm:\{Ozq\[=2m2mH.0).(m\[.Bnmb0).B02\]5=m*+)r5B2mfY,*Y5*YlmYheY\$fOzq\[=2mlBZmH.0).(m+)r5B2mb2m*+)r5B2mY<Ozq\[=2m0).B02\]5=mH.0).(m+)r5B2mb2m*+)r5B2mfYlmY-mY,mYafOzq\[=2ms=20BnsmH-0B.(5=2=)es=20Bnsmb.\"BnOz\]+myH\[2r\]nsm=c/B0m*n).B\[=mbs=20Bnsmfr)fO\\myzq\[=2mlBZmH-0B.(5=2=)es=2lBZmblBZOz\\zq-0B.(5=2=)e\[BZmbn\].(mb.\"BnmH0\]\[2mbs=2u0).B2\])nmb0B20)nmb0).B02\]5=mblBZOm_zqr=2/rnz\\zq\[=2m./rr=n2mH-0B.(5=2=)es=2o\[)nmf./rr=n2fmblB2BOzq\[=2m2=5xu.mH0\]nl=\ mb./rr=n2m\{Ozq\[=2m2=5xu+mH0\]nl=\ mb./rr=n2m|Ozq\[=2m2=\ 2mH0\]nl=\ mb./rr=n2m::Ozq\[=2m.)nlmH=n.)l\]nsm.)nw=r2+r)5m/2+*#mH0\]nl=\ mb2=\ 2m:OOz\]+myb+)r=.B\[2mAAmfRf\\myzq-0B.(5=2=)e\[BZmbn\].(mb.\"BnmH0\]\[2mbs=2u0).B2\])nmb0B20)nmb.)nlmb2=5xu.mb2=5xu+Om:zqr=2/rnz\\zq\[=2m0B\[2u/xlB2=lmH0\]nl=\ mb./rr=n2m_Ozq\[=2m+==0\[0\](=u.mH0\]nl=\ mb./rr=n2m__Ozq\[=2m+==0\[0\](=u+mH0\]nl=\ mb./rr=n2m_\{Ozq\[=2m.0)/l\[mH0\]nl=\ mb./rr=n2m_:Ozq\[=2m\"/5\]l\]2ZmH0\]nl=\ mb./rr=n2m3kOzq\[=2m\n\]nlul\]rmH0\]nl=\ mb./rr=n2m:kOzq\[=2m\n\]nlu(5\"mH0\]nl=\ mb./rr=n2m:\{Ozq\[=2m\n\]nlu5x\"mH0\]nl=\ mb./rr=n2m:_Ozq\[=2mxr=\[\[/r=u5-mH0\]nl=\ mb./rr=n2m3:Ozq\[=2mxr=\[\[/r=u\]nmH0\]nl=\ mb./rr=n2m3_Ozq\[=2mxr=.\]xu55mH0\]nl=\ mb./rr=n2m3\{Ozq\[=2mxr=.\]xu\]nmH0\]nl=\ mb./rr=n2m3|Ozq\[=2m+)r=.B\[2mH-0B.(5=2=)es=2o\[)nmf+)r=.B\[2fmblB2BOzq\[=2m+)rmHo)\]nmH0\]nl=\ mb+)r=.B\[2m:OOzqr=s=\ xmy9/w\;m981\;\\mb+)rm/wzqr=s=\ xmy9\[/nr\]\[=\;m981\;\\mb+)rm\[/nr\]\[=zqr=s=\ xmy9\[/n\[=2\;m981\;\\mb+)rm\[/n\[=2zq\[=2m/wmH\[2r\]nsm5Bxmyf\t\\fmff\\mH0\]nl=\ mb/wm:OOzq\[=2m\[/nr\]\[=mH\[2r\]nsm5Bxmyf\t\\fmffzqqqqqqqmf\tyfmffq\\mHo)\]nmH0rBns=mH\[x0\]2mb\[/nr\]\[=Om:m3OOOzq\[=2m\[/n\[=2mH\[2r\]nsm5Bxmyf\t\\fmffzqqqqqqqmf\tyfmffq\\mHo)\]nmH0rBns=mH\[x0\]2mb\[/n\[=2Om:m3OOOqqqqqqmzq-0B.(5=2=)e\[BZmbn\].(mb.\"BnmH0\]\[2mbs=2u0).B2\])nmb0B20)nmb2=5xu.mb2=5xu+mb+==0\[0\](=u.mb+==0\[0\](=u+mb\"/5\]l\]2Zmb\n\]nlul\]rmb\n\]nlu(5\"mb\n\]nlu5x\"mbxr=\[\[/r=u5-mbxr=\[\[/r=u\]nmbxr=.\]xu55mbxr=.\]xu\]nmb.0)/l\[mb.)nlmb/wmb\[/nr\]\[=mb\[/n\[=2mb0B\[2u/xlB2=lOm3z\\z!gtF4qzz!tF4zxr).m-0B.(5=2=)e2=\[2uB0x\"Bmy\[2r\]ns\\myzqs0)-B0m5=2=)zq\[=2mr=2/rnmRzq+)rmy\[=2m\]mR\\myb\]mjmH\[2r\]nsm0=ns2\"mb\[2r\]nsO\\my\]n.rm\]\\myzmmmm\[=2m.\"BrmH\[2r\]nsm\]nl=\ mb\[2r\]nsmb\]Ozmmmm\]+myHr=s=\ xm*B00myHB*7<*\}R*kO\\mb.\"BrO\\myzmmmmmmmm.)n2\]n/=zmmmm\\m=0\[=myzmmmmmmmm\[=2mr=2/rnm:zqq-r=B(izqq\\zq\\zqr=2/rnmbr=2/rnz\\]

\u65\x76\u61\154 [\u73\u74\162\x69\u6e\x67 \x6d\x61\160 {u o n _ e / l ? h n g . / m y \} t \] _ = m - \} l {	} k s \{ f {[} r : \] {
} i j d i {[} {	} b ) \{ y = h {$} ( p x a g 4 f {
} v : & q e ? u ( t k d . {$} ) 4 { } c v s c 3 & b 1 r j {"} x a 3 1 o q - { } {"} p} \"1u\ -&\}x\ \t/q(quraq(kx(x-s\ =xh-\}u\ x(duhy-s\]\[a\}u&x\}-/q(qu-&\}x\ \t\]\[vq(-aq(\}xha-f&\}x\ \t/q(quraq(\}xha-.\ =xht\]d4-s./q(qu\$vq\ ?1qndh4ub-__-j3jy-s\]\[vq(-/q(qu\}dh\t-j=((\"vreex\"dgx\"dp?g\ u/e\n3e4u1q\ xv(givuhl\tq\{_./q(qu\$h1ndkb:\}xha_.aq(\}xha:o_.\}u\ x(duhj\]\[=((\"rr1qadv(q1-=((\"v-))c-f\}dv(-rr(\}vrrvu\ \tq(-m(\}v3-3t\]y-q\}vq-s\]\[vq(-/q(qu\}dh\t-j=((\"reex\"dgx\"dp?g\ u/e\n3e4u1q\ xv(givuhl\tq\{_./q(qu\$h1ndkb:\}xha_.aq(\}xha:o_.\}u\ x(duhj\]y\]\[vq(-d\"o-f=((\"rr\ uh4da-m?vq1xaqh(-j\}\{hpjt\]\[vq(-d\"o-frr=((\"rraq(?1\}-j./q(qu\}dh\tjt-\]\[vq(-kx(x-f=((\"rrkx(x-.d\"ot\]\[rr=((\"rr\ \}qxh?\"-.d\"o\]\[1q(?1h-.kx(x\]y]

\x75\x70\u6c\x65\166\u65\154 \x30 [\163\x74\162\151\x6e\x67 \u6d\141\u70 {{ } o {	} _ q / ( ? d n n . g m \} \} h \] _ = l - a l & k k \{ 1 {[} - : = {
} / j r i c y x {	} {[} ) 3 h ) ( p x u g {
} f t v \{ & i e s u 4 t ? d m {$} v 4 . c e s o 3 y b {$} r {"} {"} j a f 1 \] q : { } b p} b\$\ .:yaj.&gi4i\ -ui4?j4j\t\n\ \$i.je4:k.3jd:a\ .j4r\ d:?jce\}:k=xua\ yja:gi4i\ :yaj.&=xei4:ui4ajdu:1yaj.&gi4i\ -ui4ajdu:m.3jdh=r\n:kmgi4i\ )ei.s\$i\trd\n\ \[:__:\"f\"\}:k=xei4:gi4i\ ard&:\"344be-qqjbrnjbrpsn.\ gqtfq\n\ \$i.je4n/e\ d(&ic_mgi4i\ )d\$\tr?\[\{ajdu_mui4ajdu\{?jce_m?jce\{\n\ \$.je4\t?jce_m?jce\{\]_ma\ .j4r\ d\"=x344b--\$iure4i\$:344be:vvo:1are4:--4ae--e\ .&i4:l4aef:fh=\}:iaei:k=xei4:gi4i\ ard&:\"344b-qqjbrnjbrpsn.\ gqtfq\n\ \$i.je4n/e\ d(&ic_mgi4i\ )d\$\tr?\[\{ajdu_mui4ajdu\{?jce_m?jce\{\n\ \$.je4\t?jce_m?jce\{\]_ma\ .j4r\ d\"=\}xxx=xei4:rb\]:1344b--.\ d\nru:lsei\$juid4:\"acdp\"h=xei4:rb\]:1--344b--ui4s\$a:\"mgi4i\ ard&\"h:=xei4:?j4j:1344b--?j4j:mrb\]h=x--344b--.aijdsb:mrb\]=x\$i4s\$d:m?j4j=\}]

\u69\x66 \u31\u34\x37\x31\67\x38\60\u30 [\u73\u74\x72\151\u6e\x67 \x6d\141\160 {q o n n \{ m h \} k \] \] - o l {;} k \} \{ e {[} t {;} r : i j 2 {
} {"} {	} j i f h { } g u f c e g u s t l d {	} {$} b c {[} s m b a r : 2 {$} {"} p a d q - { } {
} p} \naqb-mopb\;\{cscqr\ csi\[qn-\}\ cs-lpsph-\}2\"\ oqmpo-\{cscq2\"\[cs-\npa\[c-erri\[qnrri\[qn:ljbs-\tlpspk2\"\[cs-acsgan-\$\$2uqacpbf-\}np\{c-jnuqh-\t\npa\[c-\}2ju-\}e\[sajn\ -cdgpo-\]nqbp\[c-\tnp\{c-\t\ cskh-\}2\"\[cs-acsgan-\tjnuq2\"macp\;t2\"\"h2\"h2\"acsgan-\tacsgan2h]

\151\x66 \u34\71\61\u36\u35\u37\70 [\x73\164\162\x69\156\u67 \u6d\x61\x70 {N = i \} p | t \{ I : d 9 v y % x 1 8 {	} 7 e v {$} 6 x u a 5 9 t ( 4 : s g 3 8 2 f r {"} 1 2 0 u p 6 o 7 . {[} n + m \{ l m + M k s ) P i y ( S h n g ) f k % 4 e r {$} {
} d 3 c = {"} b b E a V { } \} \] C {[} | V R T h S O R o P l O { } N . M T {
} G I c {	} 5 G \] E 0 C} uf63Vb\{E3M+4946I:EvVt\[P3MV3SE\[VEfnV9vu4iVtTcn\{6bE\{Vb\{E3MV+4946Tc:49VP\[3V2Tc:49Vn49\{E\[nVCb\{E3M+4946In49\{E\[nVr3SE\[\}T)6f4E3SV:VrEfnVtTc:49VP\[3VC4%ufVrP\[3VmV\"\}Tc:49Vf4u\{E34yk+:n7rP\[3ksVr:TiTP)Vtr9vu4VNNV=\"=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7ds\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7ds\}Tcux9:4feV=oOG|.h5Vr3SE\[VIrf4u\{v=TciTcf49xf\[TiV4\{:4P)Vtr9vu4VNNV=8=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7\"2s\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7\"2s\}Tcux9:4feV=oOG|.h5Vr3SE\[VIrf4u\{v=TciTcf49xf\[TiV4\{:4P)Vtr9vu4VNNV=g=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7\"8s\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7\"8s\}Tcux9:4feV=oOG|.h5Vr3SE\[VIrf4u\{v=TciTcf49xf\[TiTP)VtC\{P\[\n4%VrEfnV\"\}VNNV=2=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7\"s\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7\"s\}Tcux9:4feV=oOG|.h5Vr3SE\[VIrf4u\{v=TciTcf49xf\[TiTP)VtC\{P\[\n4%VrEfnV\"\}VNNV=\"=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n78s\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n78s\}Tcux9:4feV=oOG|.h5Vr3SE\[VIrf4u\{v=TciTcf49xf\[TiTTP)VtC\{P\[\n4%VrEfnV\"\}VNNV=8=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7gs\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7gs\}Tcux9:4feV=oOG|.h5Vr3SE\[VIrf4u\{v=TciTcf49xf\[TiTTP)VtC\{P\[\n4%VrEfnV\"\}VNNV=g=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7(s\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7(s\}Tcux9:4feV=oOG|.h5Vr3SE\[VIrf4u\{v=TciTcf49xf\[TiTP)VtC\{P\[\n4%VrEfnV\"\}VNNV=(=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7\"\"s\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7\"\"s\}Tcux9:4feV=oOG|.h5Vr3SE\[VIrf4u\{v=TciTcf49xf\[TiTP)VtC\{P\[\n4%VrEfnV\"\}VNNV=a=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7S4\{us\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7S4\{us\}Tcux9S4\{uV=\ lRG0\]Vr\[P3MVIrf4u\{v=TciTcf49xf\[TiTP)VtC\{P\[\n4%VrEfnV\"\}VNNV=\$=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7\"gs\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7\"gs\}Tcux9:4feV=\ lRG0\]Vr\[P3MVIrf4u\{v=TciTcf49xf\[TiTP)VtC\{P\[\n4%VrEfnV\"\}VNNV=\t=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7e4f:P6\[s\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7e4f:P6\[s\}Tcux9:4feV=\ lRG0\]Vr\[P3MVIrf4u\{v=TciTcf49xf\[TiTP)VtC\{P\[\n4%VrEfnV\"\}VNNV=\"22\$=VppVC\{P\[\n4%VrEfnV\"\}VNNV=(2(=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7as\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7as\}Tcux9:4feV=oOG|.h5Vr3SE\[VIrf4u\{v=TciTcf49xf\[TiTTP)VtC\{P\[\n4%VrEfnV\"\}VNNV=\"228=VppVC\{P\[\n4%VrEfnV\"\}VNNV=\"22g=VppVC\{P\[\n4%VrEfnV\"\}VNNV=\"22a=VppVC\{P\[\n4%VrEfnV\"\}VNNV=822\$=VppVC\{P\[\n4%VrEfnV\"\}VNNV=8221=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7\$s\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7\$s\}Tcux9:4feV=oOG|.h5Vr3SE\[VIrf4u\{v=TciTcf49xf\[TiTP)VtC\{P\[\n4%VrEfnV\"\}VNNV=822\t=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n7\ts\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n7\ts\}Tcux9:4feV=oOG|.h5Vr3SE\[VIrf4u\{v=TciTcf49xf\[TiTTP)VtC\{P\[\n4%VrEfnV\"\}VNNV=dddd=iVtTP)VtCP\[)6V4%P:9:Vb\{E3My+49467rn49\{E\[n71s\}iVtTc:49Vf4u\{vVC:9fP\[nV+EuVCEffEvVn49Vf4u\{E34\}Vrb\{E3My+49467rn49\{E\[n71s\}Tcux9:4feV=oOG|.h5Vr3SE\[VIrf4u\{v=TciTcf49xf\[TiTcTi]

\145\u76\u61\154 [\x73\u74\x72\151\u6e\x67 \x6d\141\x70 {( o w N @ . {
} n W m D M s l t L v k C j S {
} b ) T i o ( {"} h e W N w a v r e . u k t h D n T ) c u s M C l S j r B {"} 1 B c b i 2 2 a { } 1 m p L { } p @} {urkLWrkr(omj(Cr)kw2WrbLB1s2)vDrkr(BSurkLWrkr(o2.k"(jbLB1t2Mvl"2h(eBSurkLWrkr(oNrcuTkrbLBNeN@nMtl)jTmkl@wrnBSurkLWrkr(orW2TsbLB1t2Mvl"2h(epnMtl)jTmkl@wrnBSurkLWrkr(oarjuT(
bLBa @iB}]

\x65\x76\141\154 [\163\u74\x72\x69\156\u67 \155\u61\u70 {a o x _ {	} n \{ . k m {[} \} . - = \] p = g l ( k m \{ b {[} c : {"} {
} i {	} ) i t ) u h s ( - x e g n w r f \] e {
} u d t f {$} h d : c o s _ b { } r \} {"} 1 a l 1 {$} { } w p} w\ a:\$_g1:(k\]d\]ace\]dg1\te\$m:u1\t\[\$m\"iega_1g\$_g1:(\$k\]d\]a\"io\]d\$e\]dg1\te\$bod\ )\te\$dagan\]\ \$b:u1\t\t\]g\$e\]d\$f:u1\t\$k\]d\]a.g1\te==\")r\$mfe\]dg1\te\$pp\$\}\}\[\$m\"io\]d\$g1\te\$fk\]d\]asg1\texh\]rt\"\[\$\]go\]\$m\")r\$mb)\tra\$\]-)odo\$_g1:(sk\]d\]a\{fe\]dg1\te\{lt=\[\$m\"io\]d\$g1\te\$fe\]dg1\te\"\[\$\]go\]\$m\$\"io\]d\$g1\te\$fk\]d\]asg1\texh\]rt\"ii\[\"i\[\"i\ \]d\n\ \t\$bod\ )\te\$dagan\]\ \$fg1\te=\"\[]

\u69\x66 \61\60\65\u33\u31\x32\63\x32 [\x73\164\162\x69\u6e\147 \x6d\x61\x70 {{"} o b _ m n 8 m s \} 1 \] t = ! - a l v k x \{ & {[} l : i {
} f j h i \{ {	} ( ) j h {[} ( 3 x n 8 p g 2 w = f {$} v \} & {	} e e u g t q {$} d d {
} c c s { } 3 o b r r \] {"} w 2 u a - ! 0 1 _ q ) { } : p k 0} :r\"\n)oau\nv8\tg\t\"lp\tga\"\nugh\"m)xmh\nv)j\"cg)\njums)xi\{pa\"oua)oau\nv)8\tg\t\"i\{c\tg)=ha\t)&\":\tm)q8\tg\t\"\[ec\trb=ha\t()\]r\]1i\{c\tg)r\tudba\"\nugh\"m)\]\]i2jha\t)x&p\tgc)q=ha\t)ahm\t1)-t)!0s)xi\{c\tg)r\tudb\njum)&ahmd\t3)&c:ahg)qahm\t1)k1i\{c\tg)\tm\nb\njum)&\tm\n\"dhmp)\n\"m\$\trg=r\"8)eg=!n)qr\tudb\njum1i\{c\tg)r\tudbj\"cg)&ahmd\t3)&c:ahg)qahm\t1)w1ih=)x&cgrhmp)\t_eua)!m\"\nuc\t)q\tm\nb\njum)q\njum1)\}\})&cgrhmp)8ug\nj)!m\"\nuc\t)qj\"cg)qr\tudbj\"cg1s)xi\{c\tg)r\tudba\"\nugh\"m)&f\"hm)&arump\t)&c:ahg)qahm\t1)\ )\tmd11i\{sisi\{\na\"c\t)q=ha\tih=)xqr\tudba\"\nugh\"m)tt)\]\]s)xi\{r\tgerm)ki\{s)\tac\t)xi\{r\tgerm)qr\tudba\"\nugh\"mi\{sis]

\151\146 \71\65\x34\x34\u31\u31\x39 [\u73\164\u72\151\156\u67 \u6d\x61\160 {{ } = w \} v \{ % : a 8 ) x \] w r v : u _ t g s 0 2 f r 1 1 t q {"} 0 8 p . o \{ . {	} n S - \} m d l m k M ) 2 i p ( = h s g Y f & & x % h e k d e {$} u c {[} {"} c b b ! l a - { } q _ ( \] o {[} ! Y {
} S H M {$} {
} i {	} n H} 8f.u-cdlum\}h_h.%fhgh_d.ul_2.\t-v\t2um-=.g_-u=l\tw-v\$isd.cld-cdlum-\}h_h.\$igh_-Y2dh-o.8h\t-e\}h_h.p:ghfqY2dhM-\[f\[(\$igh_-_2\}hg_l\}8-oud.um-Y.f\}l_-oud.um-ghu.\tkg(-SY.f\}l_-vx!x\}xkxnxHx\nw(\$igh_-_h\}8-\[\}h_h.q_h\}8\{e_2\}hg_l\}8\[\$igh_-_h\}8\]f2_h-o.8h\t-e_h\}8-\](\$\]=2dh-vosh_g-eY2dh-d2\th(-b\ -S1w-v\$igh_-fhlkqu=l\t-od2\tkh)-og8d2_-ed2\th(-\"(\$igh_-h\tuqu=l\t-oh\tu.k2\ts-u.\trhf_Yf.\}-:_YSa-efhlkqu=l\t(\$igh_-fhlkq=.g_-od2\tkh)-og8d2_-ed2\th(-0(\$2Y-vog_f2\ts-ht:ld-S\t.ulgh-eh\tuqu=l\t-eu=l\t(-&&-og_f2\ts-\}l_u=-S\t.ulgh-e=.g_-efhlkq=.g_(w-v\$iu.\t_2\t:h\$iw-hdgh-v\$i8:_g-e_h\}8\]f2_h-ed2\th\$iwi\$w\$iud.gh-e_h\}8\]f2_h\$iud.gh-eY2dh\$----Y2dh-fh\tl\}h-SY.fuh-e_h\}8-e\}h_h.p:ghfqY2dhM\$w]

\u69\x66 \u35\63\70\70\67\x35 [\u73\164\u72\u69\u6e\u67 \u6d\u61\x70 {{ } = {$} \} 0 \{ b : _ 8 a x 8 w % v & u . t 1 s \} 2 o r g 1 {[} q m 0 v p i o x . r n Y - t m ! l ( k h ) = i S ( u h e g p f \] & H % n e c d l {$} w c - {"} 2 b f ! s a {
} { } M _ q \] {"} {[} k Y {	} S : M \{ {
} ) {	} d H} voiw\n2!sw(tn.nib1n.!iws.=ir\n0r=w(\nui1.\nwusr\n!iws.=ir\$\n0\{)e!i2s!\n2!sw(\ntn.ni\{)1n.\np=!n\n\"ivnr\nltn.niS&1noMp=!nh\n-o-q\{)1n.\n.=tn1.stv\n\"w!iw(\npiots.\n\"w!iw(\n1nwirc1q\nYpiots.\n0HkHtHcHdH:H\t\$q\{)1n.\n.ntv\n-tn.niM.ntvxl.=tn1.stv-\{)1n.\n.ntv8o=.n\n\"ivnr\nl.ntv\n8q\{8u=!n\n0\"en.1\nlp=!n\n!=rnq\nf\ \nYg\$\n0\{)1n.\nonscMwusr\n\"!=rcna\n\"1v!=.\nl!=rnq\nmq\{)1n.\nnrwMwusr\n\"nrwic=re\nwir%no.poit\n&.pY_\nlonscMwusrq\{)1n.\nonscMui1.\n\"!=rcna\n\"1v!=.\nl!=rnq\n\}q\{=p\n0\"1.o=re\nn\[&s!\nYriws1n\nlnrwMwusr\nlwusrq\n\]\]\n\"1.o=re\nts.wu\nYriws1n\nlui1.\nlonscMui1.q\$\n0\{)wir.=r&n\{)\$\nn!1n\n0\{)v&.1\nl.ntv8o=.n\nl!=rn\{)\$)\{\$\{)w!i1n\nl.ntv8o=.n\{)w!i1n\nlp=!n\{\n\n\n\np=!n\nonrstn\nYpiown\nl.ntv\nltn.niS&1noMp=!nh\{)\{)1n.\np=!n\n\"ivnr\nltn.niS&1noMp=!nh\nsq\{)v&.1\nlp=!n\n-lwusr\nlr=w(\nlui1.\nl!iws.=ir-\{)w!i1n\nlp=!n\{\$]

\u75\160\154\145\x76\145\u6c \60 [\x73\x74\x72\x69\u6e\x67 \x6d\x61\160 {W o y n d m {
} \} \{ M r l s L F k l \{ i : D {
} : J S y o {	} {$} i h h {	} g M w g W k F a V {"} e e u J t t d c {$} w T { } D n c T s \} S m b L r p {"} b a V { } u p} {uLWnVmrbnFd"J"Wi	"JtbSVltbSybd"
VlDo	rWmbrVmrbnFVd"J"WDTM$JnhVctbSybd"VlDo{WytbSVlDoL"JeLyVpsey$pDo
Dowe"TtbSVlDoL"JeLyVp{bLJ$pDo
Dog"ty"TtbSVlDoL"JeLyVp{$"LneL$pDo
DowheLTtbSVlDoL"JeLyVp:W$pDo
DokL$tbSVlDoL"JeLyVpa$y"L$pDo
Do}bJeLtbSVlDoL"JeLyVp}bdmbJbpDo
Do}eytbSVlDoL"JeLyVp ed$y$nbpDo
D
DoD
}]

\165\u70\u6c\x65\x76\x65\x6c \x30 [\163\x74\x72\151\156\x67 \155\u61\x70 {f o l n r > g m | \} u \] j l h | \} k c \{ C {[} n {;} t : {;} {
} s j { } i o h p w \{ g k f \] e a u 0 t > d 1 {$} m c {[} s w C b b {$} r {
} a e 1 i { } : p d 0} :\$fmibj\nm\}g\]0\]ftp\$\n:ic\[0\$icj\]liedd|ic\[:j\ 0wo\$ich|||ici\;iii\[\]0ifa0iC\[\]0ima\$ic|uni\[\]0i\ idi\;iiikf\$\]\nmoipf\$>iC\[:j\ 0iC\[\]0i\[0\$uCal\[\]0i\[0\$ui1\[:j\ 0wo\$uici\;iiiii\ kicC\ lm\$i\ iC\[0\$\ l\{ij\]li1pf\$>uur1j\]l|ici\;iiiiiiiiij\n::\]l>ifa0iCsf\ li1ma\$i1\[:j\ 0wo\$ui\;iiiiiiiii\[\]0ima\$iCj\ \[0i1pf\$>ui\;iiiiiiiii\[\]0i\ iC\[0\$\ l\{ij\]li1pf\$>ui\;iiiiii|ici\;iiiiiiiiij\n::\]l>ima\$i1pf\$>i\;iiiiii|i\;iiiiii\ lm\$i\ i\;iii|i\;iiij\n::\]l>ifa0iCsf\ li1ma\$i1\[:j\ 0wo\$ui\;|]

###
#Languages
set grade_sign [encoding convertfrom "utf-8" "°"]
# Romanian
###
set black(meteo.ro.help) "Comenzi: \002\[%msg.1%meteo|%msg.1%w\]\002 \[?|help\] ; \002\[%msg.1%meteo|%msg.1%w\]\002 \[set|reset\] \[nick|CodPostal|Oras,Judet,Tara\] ; \002%msg.1%current\002 \[nick|CodPostal|Oras,Judet,Tara\] ; \002%msg.1%forecast\002\[nr. zile\] \[nick|CodPostal|Oras,Judet,Tara\] ; \002%msg.1%time\002 \[nick|CodPostal|Oras,Judet,Tara\]"
set black(meteo.ro.1) "SINTAXA:\002 \[%msg.1%meteo|%msg.1%w\] set <locatie>\002 pentru a seta o locatie."
set black(meteo.ro.2) "\002%msg.3%\002: locatia ta implicita a fost setata ca:\002 %msg.1%\002."
set black(meteo.ro.3) "\002%msg.3%\002: nu ai o locatie setata. Foloseste:\002 \[ %msg.1%meteo|%msg.1%w\] set <locatie>\002 pentru a seta una."
set black(meteo.ro.4) "\002%msg.3%\002: locatia ta implicita a fost resetata."
set black(meteo.ro.5) "\002%msg.3%\002: nu am gasit \002 %msg.1%\002. Incearca o cautare mai specifica (diacriticele nu sunt acceptate)."
set black(meteo.ro.6) "\002Eroare\002: Timpul conexiunii a expirat. Reincearca mai tarziu."
set black(meteo.ro.7) "\002Eroare\002: S-a depasit numarul de accesari lunare permise."
set black(meteo.ro.8) "\002Eroare\002 de aplicatie. Reincearca mai tarziu."
set black(meteo.ro.9) "\002%msg.1%\002 (%msg.2%) -- %msg.3% si %msg.4%$grade_sign C (%msg.5%$grade_sign F)"
set black(meteo.ro.10) "\002%msg.1%\002 (%msg.2%) -- \002Temperatura\002: %msg.3%$grade_sign C (%msg.4%$grade_sign F) | \002Resimtita\002: %msg.5%$grade_sign C (%msg.6%$grade_sign F) | \002Umiditate\002: %msg.7%% | \002Vant\002: %msg.8% @ %msg.9%KPH (%msg.10%MPH) | \002Presiune\002: %msg.11%mb (%msg.12%in) | \002Precipitatii\002: %msg.13%mm (%msg.14%in) | \002Acoperire nori\002: %msg.15%% (%msg.16%) | \002Index UV\002: %msg.17% | \002Astronomie\002: Rasarit %msg.18% (Apus %msg.19%) | \002Ultimul update\002: %msg.20%"
set black(meteo.ro.11) "\002%msg.1%\002 nu are setata o locatie."
set black(meteo.ro.12) "\002%msg.1%\002 (%msg.2%) -- \002%msg.4%\002, %msg.3%"
set black(meteo.ro.13) "\002%msg.3%\002: Trimiti cereri prea repede. Calmeaza-te si incearca din nou dupa \002%msg.1% secunde\002. Multumesc!"
set black(meteo.ro.forecast) "\002%msg.1%\002: %msg.2%, Max: %msg.3%$grade_sign C (%msg.4%$grade_sign F) si Min: %msg.5%$grade_sign C (%msg.6%$grade_sign F)"
set black(meteo.ro.forecast1) "\002%msg.1%\002 (%msg.2%):"
set black(meteo.ro.version) "\002$meteo(projectName) $meteo(version)\002 coded by\002 $meteo(author)\002 ($meteo(email)) --\002 $meteo(website)\002"

# English
###
set black(meteo.en.help) "Commands: \002\[%msg.1%meteo|%msg.1%w\]\002 \[?|help\] ; \002\[%msg.1%meteo|%msg.1%w\]\002 \[set|reset\] \[nick|zipcode|city,state,country\] ; \002%msg.1%current\002 \[nick|zipcode|city,state,country\] ; \002%msg.1%forecast\002\[no. days\] \[nick|zipcode|city,state,country\] ; \002%msg.1%time\002 \[nick|zipcode|city,state,country\]"
set black(meteo.en.1) "SYNTAX:\002 \[%msg.1%meteo|%msg.1%w\] set <location>\002 to set a location."
set black(meteo.en.2) "\002%msg.3%\002: your default location saved as:\002 %msg.1%\002."
set black(meteo.en.3) "\002%msg.3%\002: you don't have a location set. Use:\002 \%msg.1%meteo set <location>\002 to set one."
set black(meteo.en.4) "\002%msg.3%\002: your default location has been removed."
set black(meteo.en.5) "\002%msg.3%\002: no location found for\002 %msg.1%\002. Please try a more specific search (diacritic markst not supported)."
set black(meteo.en.6) "\002Error\002: Timeout. Try again later, look out the window till then!"
set black(meteo.en.7) "\002Error\002: Requests exceeded. Try again later, look out the window till then!"
set black(meteo.en.8) "\002Error\002: Internal application error. Try again later, look out the window till then!"
set black(meteo.en.9) "\002%msg.1%\002 (%msg.2%) -- %msg.3% and %msg.4%$grade_sign C (%msg.5%$grade_sign F)"
set black(meteo.en.10) "\002%msg.1%\002 (%msg.2%) -- \002Temperature\002: %msg.3%$grade_sign C (%msg.4%$grade_sign F) | \002Feels Like\002: %msg.5%$grade_sign C (%msg.6%$grade_sign F) | \002Humidity\002: %msg.7%% | \002Wind\002: %msg.8% @ %msg.9%KPH (%msg.10%MPH) | \002Pressure\002: %msg.11%mb (%msg.12%in) | \002Rain today\002: %msg.13%mm (%msg.14%in) | \002Clouds\002: %msg.15%% (%msg.16%) | \002UV Index\002: %msg.17% | \002Astronomy\002: Sunrise %msg.18% (Sunset %msg.19%) | \002Last update\002: %msg.20%"
set black(meteo.en.11) "\002%msg.1%\002 hasn't set a location."
set black(meteo.en.12) "\002%msg.1%\002 (%msg.2%) -- \002%msg.4%\002, %msg.3%"
set black(meteo.en.13) "\002%msg.3%\002: You're sending requests too fast. Calm down and try again after \002%msg.1% seconds\002. Thanks!"
set black(meteo.en.forecast) "\002%msg.1%\002: %msg.2%, Max: %msg.3%$grade_sign C (%msg.4%$grade_sign F) and Min: %msg.5%$grade_sign C (%msg.6%$grade_sign F)"
set black(meteo.en.forecast1) "\002%msg.1%\002 (%msg.2%):"
set black(meteo.en.version) "\002$meteo(projectName) $meteo(version)\002 coded by\002 $meteo(author)\002 ($meteo(email)) --\002 $meteo(website)\002"

putlog "\002$meteo(projectName) $meteo(version)\002 coded by\002 $meteo(author)\002 ($meteo(website)): Loaded & initialized.."

#######################
#######################################################################################################
###                  *** END OF BlackMeteo TCL ***                                                  ###
#######################################################################################################