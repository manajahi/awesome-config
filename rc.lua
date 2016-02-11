-- Standard awesome library
local awful = require("awful")
awful.rules = require("awful.rules")
awful.autofocus = require("awful.autofocus")
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local vicious = require("vicious")

-- Where most of the config files and loadable options live in my
-- Some variables intialization
home = os.getenv('HOME') or '/'
shell = os.getenv('SHELL') or 'zsh'
confdir = os.getenv("HOME") .. "/.config/awesome/"
package.path  = confdir .. "mylibs/?.lua;" .. package.path
print(package.path)
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
browser = os.getenv("BROWSER") or "google-chrome"

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
-- beautiful.init(confdir .. "/original/theme.lua")
beautiful.init(confdir .. "/solarized-dark/theme.lua")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod5"


-- load the 'run or raise' function
-- remove this after passage to awesome 3.5 or later
local ror = require("aweror")

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
   {
   awful.layout.suit.floating,
   awful.layout.suit.tile,
   --    awful.layout.suit.tile.left,
   --    awful.layout.suit.tile.bottom,
   awful.layout.suit.tile.top,
   awful.layout.suit.fair,
   awful.layout.suit.fair.horizontal,
   --    awful.layout.suit.spiral,
   --    awful.layout.suit.spiral.dwindle,
   awful.layout.suit.max,
   awful.layout.suit.max.fullscreen,
   awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which will hold all screen tags.
-- tags = {}
tags = {
   names  = { 1, 2, 3, 4, 5, 6, 7, 8, 9},
   layout = { layouts[6], layouts[2], layouts[2], layouts[2], layouts[2],
	      layouts[2], layouts[2], layouts[2], layouts[2]}
}

for s = 1, screen.count() do
   -- Each screen has its own tag table.
   tags[s] = awful.tag(tags.names, s, tags.layout)
end
-- }}}


-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awful.util.getdir("config") .. "/rc.lua" },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


-- {{{ Wibox
--  Cpu usage widget
--cpuwidget = wibox.widget.textbox({ align = "right" }) 
cpuwidget = wibox.widget.textbox()
cpuwidget.width=60
cpuwidget.align="right"
vicious.register(cpuwidget, vicious.widgets.cpu, '<span color="#00A800"><b>C: </b></span><span color="#CC9393">$1% </span>')


--  Memory usage widget
memwidget = wibox.widget.textbox()
memwidget.width=113
memwidget.align="right"
-- </span><span color="#CC9393">$1%</span>
vicious.register(memwidget, vicious.widgets.mem, '<span color="#00A800"><b>M: </b></span><span color="#CC9393"></span><span color="#00A8A8">$2MB</span>/<span color="#A8A800">$3MB</span><span color="#CC9393"></span>', 1)


--  Network usage widget
netwidget = wibox.widget.textbox()
netwidget.width=60
netwidget.align="center"
vicious.register(netwidget, vicious.widgets.net, '<span color="#00A800"><b>N: </b></span><span color="#CC9393">${eth0 down_kb}</span> <span color="#7F9F7F">${eth0 up_kb}</span>', 3)


--  Volume widget
volwidget = wibox.widget.textbox()
--volwidget:set_markup(text)
volwidget.width=47
volwidget.align="right"
vicious.register(volwidget, vicious.widgets.volume, '<span color="#00A800"><b>V: </b></span><span color="#CC9393">$1%</span>', 2, "Master")
volwidget:buttons(awful.util.table.join(
		     awful.button({ }, 1, function () awful.util.spawn("amixer -q set Master toggle", false) end),
		     awful.button({ }, 3, function () awful.util.spawn("xterm -e alsamixer", true) end),
		     awful.button({ }, 4, function () awful.util.spawn("amixer -c 0 -q set Master 1dB+", false) end),
		     awful.button({ }, 5, function () awful.util.spawn("amixer -c 0 -q set Master 1dB-", false) end)
	       ))


--  pkg updates widget
pkgwidget = wibox.widget.textbox()
pkgwidget.width=30
pkgwidget.align="center"
vicious.register(pkgwidget, vicious.widgets.pkg, '<span color="#00A800"><b>U: </b></span><span color="#CC9393">$1</span>', 600, "Debian")


-- Battery widget                                                                                   
-- Test if we are on a laptop
path = "/sys/class/power_supply/"
local laptop = os.execute( "cd " .. path )
batwidget = wibox.widget.textbox()
batwidget.width=45
batwidget.align="right"
-- Register widget                                                                                 
vicious.register(batwidget, vicious.widgets.bat, '<span color="#00A800">B: </span><span color="#A8A800">$1</span><span color="#CC9393">$2%</span>', 5, "BAT0")

-- Keyboard layout widget
kbdcfg = wibox.widget.textbox()
kbdcfg.cmd = "setxkbmap"
kbdcfg.layout = { "fr", "us", "ar" }
kbdcfg.current = 1  -- us is our default layout
kbdcfg.align="right"
kbdcfg.text = '<span color="#00A800"><b>' .. kbdcfg.layout[kbdcfg.current] .. '</b></span>'
kbdcfg.switch = function ()
   kbdcfg.current = kbdcfg.current % #(kbdcfg.layout) + 1
   local t = " " .. kbdcfg.layout[kbdcfg.current] .. " "
   kbdcfg.widget.text = '<span color="#00A800"><b>' .. kbdcfg.layout[kbdcfg.current] .. '</b></span>'
   os.execute( kbdcfg.cmd .. t )
end
-- Mouse bindings
kbdcfg:buttons(awful.util.table.join(
		  awful.button({ }, 1, function () kbdcfg.switch() end)
))



-- Textclock widget
mytextclock = awful.widget.textclock('<span color="#00A800">%a %b %d, %H:%M</span>', 10)
-- textclock = awful.widget.textclock({ align = "right"}, '<span color="#00A800">%a %b %d, %H:%M</span>', 60)
require('calendar2')
calendar2.addCalendarToWidget(mytextclock, "<span color='green'>%s</span>")

spacer = wibox.widget.textbox()
spacer.text = " "
-- }}}

-- Create a systray
mysystray =  wibox.widget.systray()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
   awful.button({ }, 1, awful.tag.viewonly),
   awful.button({ modkey }, 1, awful.client.movetotag),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, awful.client.toggletag),
   awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
   awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
)

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
   awful.button({ }, 1, function (c)
	 if c == client.focus then
	    c.minimized = true
	 else
	    -- Without this, the following
	    -- :isvisible() makes no sense
	    c.minimized = false
	    if not c:isvisible() then
	       awful.tag.viewonly(c:tags()[1])
	    end
	    -- This will also un-minimize
	    -- the client, if needed
	    client.focus = c
	    c:raise()
	 end
   end),
   awful.button({ }, 3, function ()
	 if instance then
	    instance:hide()
	    instance = nil
	 else
	    instance = awful.menu.clients({
		  theme = { width = 250 }
	    })
	 end
   end),
   awful.button({ }, 4, function ()
	 awful.client.focus.byidx(1)
	 if client.focus then client.focus:raise() end
   end),
   awful.button({ }, 5, function ()
	 awful.client.focus.byidx(-1)
	 if client.focus then client.focus:raise() end
end))

for s = 1, screen.count() do

   -- Create a promptbox for each screen
   mypromptbox[s] = awful.widget.prompt()
    --   mypromptbox[s] = awful.widget.prompt({ prompt = "<span foreground='#00A800'><b>Run:</b></span> ", layout = awful.widget.layout.horizontal.leftright })
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

   -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })   

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    -- left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    right_layout:add(cpuwidget)
    right_layout:add(spacer)
    right_layout:add(memwidget)
    right_layout:add(spacer)
    right_layout:add(pkgwidget)
    right_layout:add(spacer)
    right_layout:add(volwidget)
    right_layout:add(spacer)
    right_layout:add(batwidget)
    right_layout:add(spacer)
    -- right_layout:add(kbdcfg)
    -- right_layout:add(spacer)
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(spacer)
    right_layout:add(mytextclock)
    right_layout:add(spacer)
    right_layout:add(mylayoutbox[s])
    --   laptop == 0 and batwidget, spacer or nil, 
    --   pkgwidget, spacer,
    --   volwidget, spacer,
    --   kbdcfg.widget, spacer,
    --   netwidget, spacer,
    --   memwidget, spacer,
    --   cpuwidget, spacer,
    --         mylayoutbox[s],
    --     },
    -- }

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
   -- Add widgets to the wibox - order matters
   -- mywibox[s].widgets = {
   --    {
   -- 	 --mylauncher,
   -- 	 mytaglist[s],
   -- 	 -- mypromptbox[s],
   -- 	 spacer,
   -- 	 layout = wibox.layout.fixed.horizontal()
   --    },
   --    mylayoutbox[s], spacer,
   --    textclock, spacer,
   --    s == 1 and mysystray or nil,
   --    --       spacer,	spacer,
   --    laptop == 0 and batwidget, spacer or nil, 
   --    pkgwidget, spacer,
   --    volwidget, spacer,
   --    kbdcfg.widget, spacer,
   --    netwidget, spacer,
   --    memwidget, spacer,
   --    cpuwidget, spacer,
   --    spacer, mytasklist[s],
   --    layout = wibox.layout.fixed.horizontal()
   -- }
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
		awful.button({ }, 3, function () mymainmenu:toggle() end),
		awful.button({ }, 4, awful.tag.viewnext),
		awful.button({ }, 5, awful.tag.viewprev)
	  ))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
   awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
   awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
   awful.key({ modkey,           }, "Down", awful.tag.history.restore),
   awful.key({ modkey,           }, "Up",
	     function ()
		local screen = mouse.screen
		local curtag = awful.tag.getidx()
		if tags[screen][1] then
		   if curtag == 1 then
		      awful.tag.history.restore()
		   else
		      awful.tag.viewonly(tags[screen][1])
		   end
		end
	     end),

   awful.key({ modkey,           }, "j",
	     function ()
		awful.client.focus.byidx( 1)
		if client.focus then client.focus:raise() end
	     end),
   awful.key({ modkey,           }, "k",
	     function ()
		awful.client.focus.byidx(-1)
		if client.focus then client.focus:raise() end
	     end),
   awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

   -- Layout manipulation
   awful.key({ modkey, "Control"   }, "j", function () awful.client.swap.byidx(  1)    end),
   awful.key({ modkey, "Control"   }, "k", function () awful.client.swap.byidx( -1)    end),
   awful.key({ modkey, "Shift" }, "j", function () awful.screen.focus_relative( 1) end),
   awful.key({ modkey, "Shift" }, "k", function () awful.screen.focus_relative(-1) end),
   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
   awful.key({ modkey,           }, "Tab",
	     function ()
		awful.client.focus.history.previous()
		if client.focus then
		   client.focus:raise()
		end
	     end),

   -- Standard program
   awful.key({ modkey, "Control" }, "r", awesome.restart),
   awful.key({ modkey, "Control" }, "q", awesome.quit),
   awful.key({ modkey            }, "y",     function ()  mywibox[mouse.screen].visible = not mywibox[mouse.screen].visible end),
   awful.key({ modkey,           }, "Return",function () awful.util.spawn(terminal) end),
   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
   awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
   awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
   awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
   awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
   awful.key({ modkey, "Control" }, "n", awful.client.restore),
   -- Prompt
   awful.key({ modkey            }, "r",     function () mypromptbox[mouse.screen]:run() end),
   awful.key({ modkey            }, "x",
	     function ()
		awful.prompt.run({ prompt = "<span foreground='#00A800'><b>Run Lua code:</b></span> " },
				 mypromptbox[mouse.screen].widget,
				 awful.util.eval, nil,
				 awful.util.getdir("cache") .. "/history_eval")
	     end),

   -- lock screen
   awful.key({ modkey }, "F12", function () awful.util.spawn("xscreensaver-command -lock") end),
   -- print screen
   awful.key({        }, "Print", function () awful.util.spawn_with_shell("DATE=`date +%d-%m-%Y_%H%M%S`; shutter -f -e -o $HOME/Desktop/snapshot$DATE.png") end),

   --    awful.key({ modkey }, "w", function () awful.util.spawn("firefox") end),

   -- surfraw search
   awful.key({ modkey }, "g", function()  awful.prompt.run({ prompt = "<span foreground='#00A800'><b>Google Search:</b></span> "},
							   mypromptbox[mouse.screen].widget,
							   function(input)
							      awful.util.spawn_with_shell("sr  -browser=" .. browser .. " google " .. input)
							   end, nil,
							   awful.util.getdir("cache") .. "/history_google")
			      end),

   -- launch command in a terminal
   awful.key({ modkey }, "t", function()  awful.prompt.run({ prompt = "<span foreground='#00A800'><b>Launch in terminal:</b></span> "},
							   mypromptbox[mouse.screen].widget,
							   function(input)
							      command = shell .. " -i -c \"" .. input .."; " .. shell .. " -i\""
							      title = "\"" .. input .. "\""
							      awful.util.spawn(terminal .. " -title " .. title .. " -e " .. command)
							   end, nil, 
							   awful.util.getdir("cache") .. "/history_terminal")
			      end)
)

clientkeys = awful.util.table.join(
   awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
   awful.key({ modkey,           }, "c",      function (c) c:kill()                         end),
   awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
   awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
   awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
   awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
   awful.key({ modkey,           }, "n",
	     function (c)
		-- The client currently has the input focus, so it cannot be
		-- minimized, since minimized clients can't have the focus.
		c.minimized = true
	     end),
   awful.key({ modkey,           }, "m",
	     function (c)
		c.maximized_horizontal = not c.maximized_horizontal
		c.maximized_vertical   = not c.maximized_vertical
	     end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
   globalkeys = awful.util.table.join(globalkeys,
				      awful.key({ modkey }, "F" .. i,
				                function ()
				                      local screen = mouse.screen
				                      if tags[screen][i] then
				                          awful.tag.viewonly(tags[screen][i])
				                      end
				                end),
				      awful.key({ modkey, "Control" }, "#" .. i + 9,
						function ()
						   local screen = mouse.screen
						   if tags[screen][i] then
						      awful.tag.viewtoggle(tags[screen][i])
						   end
						end),
				      awful.key({ modkey, "Shift" }, "#" .. i + 9,
						function ()
						   if client.focus and tags[client.focus.screen][i] then
						      awful.client.movetotag(tags[client.focus.screen][i])
						   end
						end),
				      awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
						function ()
						   if client.focus and tags[client.focus.screen][i] then
						      awful.client.toggletag(tags[client.focus.screen][i])
						   end
						end))
end

clientbuttons = awful.util.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
   awful.button({ modkey }, 1, awful.mouse.client.move),
   awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
-- join with run_or_raise keys
globalkeys = awful.util.table.join(globalkeys, ror.genkeys(modkey))
root.keys(globalkeys)
-- }}}

-- 
-- {{{ Rules
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { size_hints_honor = false } },
   { rule = { },
     properties = { border_width = beautiful.border_width,
		    border_color = beautiful.border_normal,
		    focus = true,
		    keys = clientkeys,
		    buttons = clientbuttons } },
   { rule = { class = "MPlayer" },
     properties = { floating = true } },
   { rule = { class = "pinentry" },
     properties = { floating = true } },
   { rule = { class = "Gimp" },
     properties = { floating = true } },
   -- Set iceweasel to always map on tag number 1 of screen 1
   { rule = { class = "Iceweasel" },
     properties = { tag = tags[1][1] } },
   { rule = { class = "Icedove" },
     properties = { tag = tags[1][1] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
			       -- Add a titlebar
			       -- awful.titlebar.add(c, { modkey = modkey })

			       -- Enable sloppy focus
			       c:connect_signal("mouse::enter", function(c)
							       if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
							       and awful.client.focus.filter(c) then
							       client.focus = c
							    end
							 end)

			       if not startup then
				  -- Set the windows at the slave,
				  -- i.e. put it at the end of others instead of setting it master.
				  -- awful.client.setslave(c)

				  -- Put windows in a smart way, only if they does not set an initial position.
				  if not c.size_hints.user_position and not c.size_hints.program_position then
				     awful.placement.no_overlap(c)
				     awful.placement.no_offscreen(c)
				  end
			       end
			    end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
