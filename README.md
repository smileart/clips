# 📎 CLIPS :: CLI tiPS
<img src="./img/hero.png" width="700" />

## About

<p>🌇 CLIPS is a series of GIF-casts with various CLI tips.</p>
<p>🧰 At the same time it's a collection of tools/links and a few bash scrips helping me to create those GIF-casts.</p>

## Usage

````shell
source ./start ./scenarios/s0e0.txt ./episodes/s0e0/s0e0_
. ./next           # echoes the first line of the scenario
n                  # OR using alias
n s 1 1            # OR rewinding to a certain scene/line
n s 1 1 && n s 2 5 # OR playing a few scenes in one go
````

**Here's a short glossary of terms I'm using in CLIPS**

* Scenario – is a txt file with lines we want to output one by one using different styles and options available in the `next` script
* Scene - is a script containing the whole uninterrupted sequence of lines being printed as specified in the scene (used to print annotations, etc.)
* finalcut.txt - a human readable reminder of how to play the whole episode (including the instructions about manual demos, etc.)

**Here's the list of all the possible `next` args**:

| next argument            | possible parameters             | CLIPS feature                                                                            |
| :----------------------: | ------------------------------- | ---------------------------------------------------------------------------------------- |
|                          |                                 | no argument; prints the next line as a usual echo                                        |
|            _             |                                 | prints the next line with typing effect                                                  |
|            +             | any of the `n` arguments or `+` | prints the clipboard contents using `next` with a specified effect                       |
|            a             |                                 | prints the next line as an annotation (echo till the "✂︎" separator, typing effect after) |
|            b             | any parameter                   | prints the next line as Bear's cue ("✂︎" symbol used as a character/cue separator)        |
|            c             | any parameter                   | prints the next line as a command (executes it if no argument passed)                    |
|            d             | `ey~es` `fa~ce`                 | prints the next line as Dude's cue                                                       |
|            e             |                                 | executes the next line as an expect one-liner                                            |
|            p             | `command`                       | passes the next line to a specified command using pipe                                   |
|            s             | `scene #` `line #`              | executes the next "scene" script (with args passed: forces scene and scenario line #)    |
|            t             |                                 | prints the next line as a title (using `toilet`)                                         |
|            k             |                                 | prints the next line as a key combination / keyboard shortcut                            |
|            y             |                                 | puts the next line to the clipboard (aka yanks it)                                       |

**Here are some tips on scenarios creation**:

* The execution and sourcing of the `next` script [are different](https://superuser.com/questions/176783/what-is-the-difference-between-executing-a-bash-script-vs-sourcing-it) and since it relies on environment we need to source it or use `n` alias to run the next line of the scenario
* There's no need to create any scenes (and passing the prefix) if you're not planning on using multi-line outputs (like annotations) or custom delays/clears
* Titles (`t`) have `pagga` font and piped to `lolcat` by default, for any customisations see `p` parameter
* The Dude (`d`) has a few tricks up his sleeve:
  - The line is automatically trimmed, to preserve any trimmable chars use escaping with `\`
  - The Dude has customisable face features, pass first argument with `~` separator to set eyes and the second to set the mouth and the nose (please notice: if you want to have a space symbol in the Dude's face, use `␠` symbol instead, which is going to be replaced with space. This was needed cause `echo $(echo x~x  ~o)` trims the space in the second pare when passing it as an argument in `eval_script` in case you were wondering...):
    - `n d ಠ~ಠ" ␠~ʖ`
    - `n d x~x" ␠~ʖ`
    - `n d ʘ~ʘ" ｡~ʖ`
    - `n d ●~●" _~ʖ`
    - `n d °~°" ⎵~⌡`
    - `n d ⚙~ಠ" ⏠~ʖ`
* The Bear command `b` is called bear cause the Bear is the default emote character used in the command. Although, if you pass anything as a second argument: `n b _`, the line gonna be interpreted as the one consisting of two parts `ʕ•́ᴥ•̀ʔっ✂︎Hello, World!` the custom character `ʕ•́ᴥ•̀ʔっ` and its cue `Hello, World!` separated by `✂︎`. **NOTE**: mind though, not every symbol can be displayed in every terminal, so test your characters with `n + +` before using them in the actual scenario.
    - `ʕ•́ᴥ•̀ʔっ✂︎Hello, World!`
    - ```ᕙ(`▿´)ᕗ✂︎Hello, World!```
    - `(•◡•)/✂︎Hello, World!`
    - `٩(˘◡˘)۶✂︎Hello, World!`
    - `⊂･_ʖ･⊃✂︎Hello, World!`
* Command (`c`) could be either typed and executed or just typed: `n c _`
  - Using a special separator char `✂︎` it's possible to make pre-/post-hook commands to be executed before the original command
  - If the command has no "hooks" it's gonna be printed/executed as usual
  - Instead of aliases in "hooks" it's better to use functions, because of non-interactive shell alias expansion issues (see: https://bit.ly/3ans9w5)
* Annotations (`a`) make sense only in scenes or `n a && n a && n a` execution sequences, since they take multiple lines
* Annotations (`a`) have a special separator `✂︎` which divides the lines and the annotation printing. The former is faster and the latter is with the typing effect
* Typing effect is a simple `pv` command, the parameter `_` for typing effect output means to represent a typing cursor
* Scenes (`s`) functionality is an abstraction on top of `next` command, which for GIF-cast purposes allows to:
  - hide actual commands behind the CLIPS
  - automate the series of commands
  - avoid having prompt in between separate commands
  - have multiple scenes to manually show something in between and go to the next one
  - rewind to sub-sections of the CLIPS
* Scenes optionally accept two args `scene number` and `line number` to force the current scene and rewind the scenario to the appropriate line
  - If you have identical scenes for different starting lines, there's no need to duplicate them, just call the same scene with an appropriate line number
* Pipes `p` allow to delegate line output to any command(s) to extend CLIPS possibilities without overcomplicating the script (escape hatch):
  - `n p cowsay -f udder | lolcat` (see `/usr/local/share/cows`)
  - `n p cowthink -f elephant`
* To output a key combination / Shortcut use `k` option with a line like `Ctrl+Alt+Del`, `Cmd+Ctrl+Shift+4`, `a`, `,+l`, etc.
* A `+` option could be used while developing or testing the functionality of `next` since it allows to output the line from clipboard as if it was the next line. E.g. `. ./next + k` with `Ctrl+Alt+Del` in the clipboard allows to output this line as a keyboard shortcut. **NOTE**: the line number of the current scenario/scene number are not bumped by this option.
* Another cool testing option is to pass `+` as an argument of `+`, i.e. `. ./next + +`. As with the `+` option it's going to get the content if the clipboard, but this time it's going to be interpreted line by line where every `odd` line would be treated as content and copied to clipboard and every other (`even`) line gonna be evaluated with `next + <...>` command. Consider an example:
    ````shell
    clear && sleep 2
    c
    ⌘ Cmd+R
    k
    \e[38;5;221m   ─────────┬────────\e[38;5;255m
    a
    \e[38;5;221m            └──── ✂︎ a common hotkey to \e[38;5;196mrefresh\e[38;5;255m\e[38;5;221m the content\e[38;5;255m
    a
    Title
    t
    I'm The Dude
    d x~x ␠~ʖ
    ````
    **NOTE**: After evaluating the above with `n + +` you'd find your clipboard empty.


## [Episodes](./EPISODES.md)

## CLIPS Tech Specs && Tips

* Term size: `tput cols && tput lines` = `125 × 32`
* Recording size: `1080x620`
* Required $TERM: `xterm-256color`
* vim scissors: `Ctrl+v u2702` (https://unicode-table.com/en/2702/)
* Print scenario: `echo "$(cat ./scenarios/s0e0.txt)"`
* Bash tmp prompt warm preset: `PS1="\[\e[38;5;214m\]$(tput bold)~/clips\n\[\e[0m\]\[\e[38;5;202m\]❯ \[\e[0m\]"`[*](https://unix.stackexchange.com/questions/207941/custom-bash-prompt-cursor-positioning-issue)
* Bash tmp prompt cold preset: `PS1="\[\e[38;5;38m\]$(tput bold)~/clips\n\[\e[0m\]\[\e[38;5;40m\]❯ \[\e[0m\]"`
* To get ANSI escape code for a given CSS Hex colour use our tool `./tools/cc '#f5e831'` (`cc` stands for 'colour code')
* To test all the features copy `test.txt` content and run `n + +`

## Resources and Deps

* `brew install coreutils`
* https://robotmoon.com/256-colors/ - useful 256 colour reference
* https://gist.github.com/XVilka/8346728 – about terminal colours support
* https://chrisyeh96.github.io/2020/03/28/terminal-colors.html – ANSI escape code reference
* https://en.wikipedia.org/wiki/Box-drawing_character - annotations drawing chars reference
* https://github.com/cacalabs/toilet - toilet docs
* http://ivarch.com/programs/pv.shtml - pv docs
* https://github.com/busyloop/lolcat - lolcat docs
* https://github.com/keycastr/keycastr - keycastr app
* https://ixeau.com/keystroke-pro -  Keystroke Pro app
* https://github.com/mvdan/sh – a shell parser, formatter, and interpreter
* https://github.com/koalaman/shellcheck - linting reference
* https://www.csie.ntu.edu.tw/~r92094/c++/VT100.html - VT100 escape codes
* http://www.cheat-sheets.org/saved-copy/TclTk_quickref.pdf - Tcl/Tk Reference Guide
* https://gist.github.com/smileart/6cf5de61d5f393d26fa0 - vim.min
* https://www.linuxcommand.org/lc3_adv_tput.php - tput text effects and stuff
* https://jungar.net/ExpectCheatSheet.php - expect cheat-sheet
* [https://chrome.google.com/webstore/detail/gif-scrubber](https://chrome.google.com/webstore/detail/gif-scrubber/gbdacbnhlfdlllckelpdkgeklfjfgcmp) - GIF player with speed control
