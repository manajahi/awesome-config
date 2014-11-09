---------------------------
-- Default awesome theme --
---------------------------
theme = {}

theme.my_original_path = "/home/amine/.config/awesome/original"
theme.font          = "sans 8"

-- try not to use transparency: it is bullshit 
theme.bg_normal     = "#000000" --"90" <-- for transparency
theme.bg_focus      = "#ffffff"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#000000" 

theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#000000"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "3"
theme.border_normal = "#696969"
theme.border_focus  = "#800000"
theme.border_marked = "#91231c"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme.my_original_path .. "/taglist/squarefw.png"
theme.taglist_squares_unsel = theme.my_original_path .. "/taglist/squarew.png"

-- theme.tasklist_floating_icon = "/home/amine/.config/awesome/theme/tasklist/floatingw.png"
-- theme.tasklist_floating_icon = "/home/amine/.config/awesome/theme/tasklist/butterfly-16.png"
-- theme.tasklist_floating_icon = "/home/amine/.config/awesome/theme/tasklist/max.png"


-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme.my_original_path .."/submenu.png"
theme.menu_height = "30"
theme.menu_width  = "200"

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
-- theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = theme.my_original_path .."/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme.my_original_path .."/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme.my_original_path .."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme.my_original_path .."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.my_original_path .."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme.my_original_path .."/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme.my_original_path .."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme.my_original_path .."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.my_original_path .."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme.my_original_path .."/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme.my_original_path .."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme.my_original_path .."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.my_original_path .."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme.my_original_path .."/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.my_original_path .."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.my_original_path .."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.my_original_path .."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme.my_original_path .."/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
-- theme.wallpaper_cmd = { "awsetbg -f /home/amine/.config/awesome/theme/gray_fox2.jpg" }

-- You can use your own layout icons like this:
theme.layout_fairh = theme.my_original_path .."/layouts/fairhw.png"
theme.layout_fairv = theme.my_original_path .."/layouts/fairvw.png"
theme.layout_floating  = theme.my_original_path .."/layouts/floatingw.png"
theme.layout_magnifier = theme.my_original_path .."/layouts/magnifierw.png"
theme.layout_max = theme.my_original_path .."/layouts/maxw.png"
theme.layout_fullscreen = theme.my_original_path .."/layouts/fullscreenw.png"
theme.layout_tilebottom = theme.my_original_path .."/layouts/tilebottomw.png"
theme.layout_tileleft   = theme.my_original_path .."/layouts/tileleftw.png"
theme.layout_tile = theme.my_original_path .."/layouts/tilew.png"
theme.layout_tiletop = theme.my_original_path .."/layouts/tiletopw.png"
theme.layout_spiral  = theme.my_original_path .."/layouts/spiralw.png"
theme.layout_dwindle = theme.my_original_path .."/layouts/dwindlew.png"

theme.awesome_icon = theme.my_original_path .."/debian.png"
theme.tasklist_floating_icon = "max.png"

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:encoding=utf-8:textwidth=80
