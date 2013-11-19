## VCS Gutter

**Now supporting Sublime Text 3.**

VCS Gutter is a plugin for Sublime Text 2 and 3 that displays an icon in the gutter area indicating whether a line has been inserted, modified or deleted relative to the version of the file in the local source
code repository. Supports Git, Mercurial and Subversion.

VCS Gutter is a "friendly fork" that builds on the original work by
[jisaacks](https://github.com/jisaacks) on [GitGutter](https://github.com/jisaacks/GitGutter).

### Screenshot:

![screenshot](https://raw.github.com/bradsokol/VcsGutter/master/screenshot.png)

### Installation

You can install via [Sublime Package Control](http://wbond.net/sublime_packages/package_control)  
Or you can clone this repo into your *Sublime Text 2/Packages*

*Mac OS X*
```shell
cd ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/
git clone git://github.com/bradsokol/VcsGutter.git "VCS Gutter"
```

*Ubuntu*
```shell
cd ~/.config/sublime-text-2/Packages
git clone git://github.com/bradsokol/VcsGutter.git "VCS Gutter"
```

*Windows*

```shell
cd %USERPROFILE%\AppData\Roaming\Sublime Text 2\Packages
git clone git://github.com/bradsokol/VcsGutter.git "VCS Gutter"
```

VcsGutter assumes that the `git`, `hg`, `svn` and `diff` commands are availible on the command line. The installers for these tools may not add the directory containing the executables to the PATH environment variable. If not, you must add the appropriate directory to your PATH variable.

For example:
```dos
 %PATH%;C:\Program Files (x86)\Git\bin;C:\Program Files (x86)\Git\cmd
```

### Settings

Settings are accessed via the <kbd>Preferences</kbd> > <kbd>Package Settings</kbd> > <kbd>VCS Gutter</kbd> menu.

Default settings should not be modified, as they are overwritten when VCS Gutter is updated. Instead, you should copy the relevant settings into VCS Gutter's user settings file.

#### Live Mode
By default, VCS Gutter detects changes every time the file is modified. If you experience performance issues you can set it to only run on save by setting `live_mode` to `false`.

#### Non Blocking Mode
By default, VcsGutter runs in the same thread which can block if it starts to perform slowly. Usually this isn't a problem but depending on the size of your file or repo it can be. If you set `non_blocking` to `true` then VcsGutter will run in a seperate thread and will not block. This does cause a slight delay between when you make a modification and when the icons update in the gutter. This is a ***Sublime Text 3 only feature***. Sublime Text 2 users can turn off live mode if performance is an issue.

#### Executable Path
If your VCS executable (git, hg, or svn) or diff utility is not in your PATH, you may need to set the `vcs_paths` setting to the location of your executables:
```js
{
    "vcs_paths": {
        "diff": "diff",
        "git": "git",
        "hg": "/usr/local/bin/hg",
        "svn": "svn"
    }
}
```

#### Colors
The colors come from your *color scheme* **.tmTheme** file. If your color scheme file does not define the appropriate colors (or you want to edit them) add an entry that looks like this:

```xml
<dict>
  <key>name</key>
  <string>diff.deleted</string>
  <key>scope</key>
  <string>markup.deleted</string>
  <key>settings</key>
  <dict>
    <key>foreground</key>
    <string>#F92672</string>
  </dict>
</dict>
<dict>
  <key>name</key>
  <string>diff.inserted</string>
  <key>scope</key>
  <string>markup.inserted</string>
  <key>settings</key>
  <dict>
    <key>foreground</key>
    <string>#A6E22E</string>
  </dict>
</dict>
<dict>
  <key>name</key>
  <string>diff.changed</string>
  <key>scope</key>
  <string>markup.changed</string>
  <key>settings</key>
  <dict>
    <key>foreground</key>
    <string>#967EFB</string>
  </dict>
</dict>
```


