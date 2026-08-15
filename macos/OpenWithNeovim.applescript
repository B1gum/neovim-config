on run
    -- Intentionally do nothing when Neovim.app is opened without a file.
end run

on open theFiles
    if (count of theFiles) is 0 then return

    set fileArgs to ""
    repeat with aFile in theFiles
        set filePath to POSIX path of aFile
        set fileArgs to fileArgs & " " & quoted form of filePath
    end repeat

    set firstPath to POSIX path of item 1 of theFiles
    set parentDir to do shell script "/usr/bin/dirname " & quoted form of firstPath

    -- Use a login shell so Homebrew's PATH (and therefore nvim) is available.
    set innerCommand to "cd " & quoted form of parentDir & " && exec nvim" & fileArgs
    set shellCommand to "/bin/zsh -lc " & quoted form of innerCommand

    tell application "iTerm2"
        activate

        if (count of windows) is 0 then
            create window with default profile command shellCommand
        else
            tell current window
                create tab with default profile command shellCommand
            end tell
        end if
    end tell
end open
