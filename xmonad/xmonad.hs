import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Hooks.ManageDocks
import Graphics.X11.ExtraTypes.XF86
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import System.IO
import XMonad.Actions.WorkspaceNames
import XMonad.Actions.SpawnOn


import qualified XMonad.StackSet as W
import qualified Data.Map        as M

spawnToWorkspace :: String -> String -> X ()
spawnToWorkspace program workspace = do
                                    windows $ W.greedyView workspace
                                    spawn program
                                     

myWorkspaces = ["1", "2", "3", "4n","5", "6", "7g", "8", "9", "10"] ++ map show [11..17]
altMask = mod1Mask
main = do
    xmproc <- spawnPipe "xmobar /home/mivin/.config/xmobar/xmobarrc"
    xmonad $ docks def
        {
            modMask            = mod4Mask,
            terminal           = "terminator",
            keys               = myKeys,
            normalBorderColor  = "#2b2b2b",
            focusedBorderColor = "#d8dee9",
            borderWidth        = 2,
            clickJustFocuses   = False,
            focusFollowsMouse  = True,
            workspaces         = myWorkspaces,

            --hooks
            layoutHook         = myLayout,
            manageHook         = manageSpawn <+> myManageHook,
            startupHook        = myStartupHook,
            logHook            = dynamicLogWithPP $ xmobarPP { ppOutput = hPutStrLn xmproc , ppSep = "   " }

        }

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    [ ((modm,               xK_x     ), spawn "kitty")
    , ((modm,               xK_d     ), spawn "dmenu_run -fn 'Noto Sans-14'")
    , ((modm,               xK_p     ), spawn "arandr")
    , ((modm,               xK_b     ), spawn "librewolf")
    , ((modm,               xK_c     ), spawn "code")
    , ((modm,               xK_v     ), spawn "vmware" )
    , ((modm,               xK_e     ), spawn "pcmanfm")
    , ((modm .|. shiftMask, xK_z     ), spawn "bitwarden")
    , ((modm .|. shiftMask, xK_x     ), spawn "spotify")
    , ((modm .|. shiftMask, xK_b     ), spawn "firefox")
    , ((modm,               xK_z     ), spawn "flameshot gui")
    , ((modm,               xK_q     ), kill)
    , ((0, xF86XK_AudioRaiseVolume         ), spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")
    , ((0, xF86XK_AudioLowerVolume         ), spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%")
    , ((0, xF86XK_AudioMute                ), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((0, xF86XK_MonBrightnessDown        ), spawn "xbacklight -dec 10")
    , ((0, xF86XK_MonBrightnessUp          ), spawn "xbacklight -inc 10")
    , ((altMask,                xK_w       ), spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%")
    , ((altMask,                xK_s       ), spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%")
    , ((altMask.|. shiftMask   ,xK_s       ), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle")
    , ((altMask .|. controlMask,xK_w       ), spawn "xbacklight -inc 10")
    , ((altMask .|. controlMask,xK_s       ), spawn "xbacklight -dec 10")
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    -- Quit xmonad
    , ((modm .|. shiftMask, xK_e     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_r     ), spawn "xmonad --recompile; xmonad --restart")



    ]
    ++

    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. controlMask .|. modm , key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_1, xK_2, xK_3] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]


myStartupHook = do
            spawnOnce "feh --bg-fill /home/mivin/Setup/Wallpapers/punk_city.jpg"
            spawnOnce "redshift -l 18.007202:79.558296"
            spawnOnce "autorandr -c"
            spawnOnce "rclone --vfs-cache-mode writes mount \"College-OneDrive\":  ~/College"
            spawnOnce "bitwarden"

myManageHook = composeAll
    [ className =? "Galculator"                     --> doFloat
    , className =? "Lxappearance"                   --> doFloat
    , className =? "Sxiv"                           --> doFloat
    , className =? "Microsoft Teams Notification"   --> doFloat
    , className =? " BashTOP"                       --> doFloat
    , className =? "qpdfview"                       --> doFloat
    , className =? "Nitrogen"                       --> doFloat
    , className =? "Bitwarden"                      --> doFloat
    , className =? "Microsoft Teams Notification"   --> doFloat 
    , resource  =? "desktop_window"                 --> doIgnore
    , className =? "LibreWolf"                      --> doShift "1" 
    , className =? "firefox"                        --> doShift "2" 
    , className =? "Vmware"                         --> doShift "3" 
    , className =? "Notion"                         --> doShift "4"
    , className =? "Com.gitlab.newsflash"           --> doShift "6" 
    , className =? "Microsoft Teams - Preview"      --> doShift "7" 
    , className =? "Microsoft Teams Notification"   --> doShift "7" 
    , className =? "discord"                        --> doShift "8" 
    , className =? "obs"                            --> doShift "8" 
    , className =? "Spotify"                        --> doShift "9" 
    , className =? "TelegramDesktop"                --> doShift "10"
    , className =? "Signal"                         --> doShift "10"
    ]

myLayout = avoidStruts(tiled ||| Mirror tiled ||| Full)
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = spacing 5 $ Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
