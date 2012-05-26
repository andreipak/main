import XMonad
import XMonad.Util.EZConfig  -- key/mouse bindings
import XMonad.Actions.CopyWindow -- for copyToAll
import qualified XMonad.StackSet as W -- for W.focusDown

main = do
  xmonad $ defaultConfig 
    { terminal    = "sakura"
    , borderWidth = 0
    , focusedBorderColor = "#2f2f2f" -- "#000000"
    , normalBorderColor  = "#353535"
    , modMask     = mod4Mask
    , manageHook = myManageHook
    , workspaces = myWorkspaces
--    , layoutHook = myLayout
    } `additionalKeysP` myKeysP
-- Define amount and names of workspaces  
myWorkspaces = ["1:web","2:edit","3:whatever","4:media","5:im","6:mail"]
-- appName/className/title to workspace
myManageHook = composeAll  
 [ className =? "Firefox"       --> doShift "1:web"
 , className =? "Emacs"         --> doShift "2:edit"
 , className =? "Vlc"           --> doShift "4:media"
 , className =? "Pidgin"        --> doShift "5:im"
 , className =? "Thunderbird"   --> doShift "6:mail"
 , className =? "Xfce4-notifyd" --> doF W.focusDown <+> doF copyToAll
 ]
-- M - modMask, M1 - Alt, C - Control, S - Shift  
myKeysP = [ ("<XF86MonBrightnessUp>",   spawn "brightness inc 25")
          , ("<XF86MonBrightnessDown>", spawn "brightness dec 25")   
          , ("<XF86Launch1>",           spawn "brightness toggle")
          , ("<XF86AudioRaiseVolume>",  spawn "volume inc 5")
          , ("<XF86AudioLowerVolume>",  spawn "volume dec 5")
          , ("<XF86AudioMute>",         spawn "volume toggle")
          , ("<Pause>",                 spawn "slock")
          , ("M-f",                     spawn "firefox")
          , ("M-a",                     spawn "sudo -u anonfox -H firefox")
          , ("M-e",                     spawn "emacsscript && emacsclient -c")
          , ("M-s",                     spawn "sakura")
          , ("<XF86PowerOff>",          spawn "sudo pm-suspend")
          , ("S-<XF86PowerOff>",        spawn "sudo shutdown -h now")
          , ("C-<XF86PowerOff>",        spawn "sudo reboot")
          , ("S-M1-q",                  spawn "translate.sh")
          , ("C-;",                     spawn "synclient TouchpadOff=$(synclient -l | grep -c 'TouchpadOff.*=.*0')")
          , ("M-d",                     spawn "showdate.sh")
          ]