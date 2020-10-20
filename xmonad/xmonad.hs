import XMonad
import Data.Monoid
import System.Exit
import XMonad.Util.SpawnOnce
import XMonad.Hooks.Manage

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

main = xmonad defaultConfig
        {
            modMask            = mod4Mask,
            terminal           = "termite",
            keys               = myKeys,
            normalBorderColor  = "#2e3440",
            focusedBorderColor = "#bf616a",
            borderWidth        = 2,
            clickJustFocuses   = False,
            focusFollowsMouse  = True,

            --hooks
            layoutHook         = myLayout,
            manageHook         = myManageHook,
            startupHook        = myStartupHook

        }

myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_x     ), spawn "termite")

    -- launch dmenu
    , ((modm,               xK_d     ), spawn "dmenu_run")

    -- launch arandr
    , ((modm,               xK_p     ), spawn "arandr")

    -- launch Firefox
    , ((modm,               xK_b     ), spawn "firefox")

    -- launch code
    , ((modm,               xK_c     ), spawn "code")

    -- launch Virtualbox
    , ((modm,               xK_v     ), spawn "virtualbox -style kvantum-dark U%")

    -- launch pcmanfm
    , ((modm,               xK_e     ), spawn "pcmanfm")
    
    -- launch Bitwarden
    , ((modm .|. shiftMask, xK_z     ), spawn "bitwarden")

    -- launch Spotify
    , ((modm .|. shiftMask, xK_x     ), spawn "spotify")

    -- launch Falmeshot
    , ((modm,               xK_z     ), spawn "flameshot gui")

    -- close focused window
    , ((modm,               xK_q     ), kill)

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
                spawnOnce "feh --bg-scale /Vault/setup/Wallpapers/arc.png"
                spawnOnce "picom -f &"
                spawnOnce "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
                spawnOnce "xrandr --output eDP1 --mode 192x1080 --pos 0x1080 --rotate normal --output DP1 --off --output HDMI1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output VIRTUAL1 --off"
                spawnOnce "rclone --vfs-cache-mode writes mount "College-OneDrive":  ~/College"

myManageHook = composeAll
    [ className =? "Galculator"                     --> doFloat
    , className =? "Lxappearance"                   --> doFloat
    , className =? "Sxiv"                           --> doFloat
    , className =? "Microsoft Teams Notification"   --> doFloat
    , className =? " BashTOP"                       --> doFloat
    , className =? "qpdfview"                       --> doFloat
    , className =? "feh"                            --> doFloat
    , className =? "Bitwarden"                      --> doFloat
    , resource  =? "desktop_window"                 --> doIgnore
    , resource  =? "kdesktop"                       --> doIgnore ]

myLayout = tiled ||| Mirror tiled ||| Full
  where
     -- default tiling algorithm partitions the screen into two panes
     tiled   = Tall nmaster delta ratio

     -- The default number of windows in the master pane
     nmaster = 1

     -- Default proportion of screen occupied by master pane
     ratio   = 1/2

     -- Percent of screen to increment by when resizing panes
     delta   = 3/100
