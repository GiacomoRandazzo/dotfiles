-- REFS:
-- (Creating a simple menubar item) https://www.hammerspoon.org/go/#simplemenubar
-- https://chris.zarate.org/create-custom-macos-menu-bar-apps-using-hammerspoon
-- (hs.execute) https://www.hammerspoon.org/docs/hs.html#execute

-- #:

-- $HOME
pathHome = "/Users/giacomoran"

-- REFS: (Designing a menu bar icon) https://bjango.com/articles/designingmenubarextras/
pathIcon100 = pathHome .. "/.hammerspoon/assets/KMonad-logo-100.png"
pathIcon35 = pathHome .. "/.hammerspoon/assets/KMonad-logo-35.png"

pathKMonad = pathHome .. "/.local/bin/kmonad"
pathKMonadKeymap = pathHome .. "/.config/kmonad/mbp.kbd"

function cliStartKMonad()
    -- `hs.execute` is blocking. Use `io.popen` to start a background process
    -- REFS: https://www.reddit.com/r/hammerspoon/comments/w1a0j2/comment/ign5evc/?utm_source=share&utm_medium=web2x&context=3
    return io.popen("sudo " .. pathKMonad .. " " .. pathKMonadKeymap)
end

function cliKillKMonad() hs.execute("sudo killall kmonad") end

function cliIsKMonadRunning()
    countProcesses = hs.execute("ps aux | grep -v grep | grep -c kmonad")
    return tonumber(countProcesses) > 0
end

-- #:

function startKMonad()
    -- Skip if KMonad is alredy running
    isRunning = cliIsKMonadRunning()
    if isRunning then
        hs.notify.new({ title = "KMonad", informativeText = "KMonad is already running." }):send()
        return
    end

    cliStartKMonad()
end

function stopKMonad()
    cliKillKMonad()
end

-- #:

-- Global state: bool to indicate whether KMonad is running
isRunning = false

-- Global state: menu items
-- REFS: https://github.com/Hammerspoon/hammerspoon/issues/1923#issuecomment-653955584
menuItems = nil

-- Global state: the menu
menu = hs.menubar.new()
-- The function passed to `setMenu` will be executed on open
menu:setMenu(function () return menuItems end)

function setMenuIcon()
    if isRunning then menu:setIcon(pathIcon100) else menu:setIcon(pathIcon35) end
end

function setMenu()
    menuItems = {
        {
            title = "Enable KMonad",
            checked = isRunning,
            fn = function()
                if isRunning then stopKMonad() else startKMonad() end
                isRunning = not isRunning

                setMenuIcon()
                setMenu()
            end
        },
        {
            title = "Force stop",
            fn = function()
                stopKMonad()
                isRunning = false

                setMenuIcon()
                setMenu()
            end
        }
    }
end

-- Launch KMonad at login (assumes Hammerspoon is launched at login).
isRunning = cliStartKMonad()

setMenuIcon()
setMenu()


