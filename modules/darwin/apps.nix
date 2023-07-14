{ pkgs, ...}: {

  ##########################################################################
  # 
  #  MacOS specific nix-darwin configuration
  #
  #  Nix is not well supported on macOS, I met some strange bug recently.
  #  So install apps using [homebrew](https://daiderd.com/nix-darwin/manual/index.html#opt-homebrew.enable) here.
  # 
  ##########################################################################

  system = {
    defaults = {
      # customize dock
      dock = {
        autohide = true;
        show-recents = false;  # disable recent apps

        # customize Hot Corners(触发角, 鼠标移动到屏幕角落时触发的动作)
        wvous-tl-corner = 2;  # Mission Control
        wvous-tr-corner = 13;  # Lock Screen
        wvous-bl-corner = 3;  # Application Windows
        wvous-br-corner = 4;  # Desktop
      };

      # customize finder
      finder = {
        _FXShowPosixPathInTitle = true;  # show full path in finder title
        AppleShowAllExtensions = true;  # show all file extensions
        FXEnableExtensionChangeWarning = false;  # disable warning when changing file extension
        QuitMenuItem = true;  # enable quit menu item
        ShowPathbar = true;  # show path bar
        ShowStatusBar = true;  # show status bar
      };

      # customize trackpad
      trackpad = {
        Clicking = true;  # enable tap to click
        Dragging = true;  # enable tap to drag
        TrackpadRightClick = true;  # enable two finger right click
        TrackpadThreeFingerDrag = true;  # enable three finger drag
      };

      # customize macOS
      NSGlobalDomain = {
        "com.apple.swipescrolldirection" = true;  # enable natural scrolling
        "com.apple.sound.beep.feedback" = 0;  # disable beep sound when pressing volume up/down key
        AppleInterfaceStyle = "Dark";  # dark mode
        AppleKeyboardUIMode = 3;  # Mode 3 enables full keyboard control.
        ApplePressAndHoldEnabled = true;  # enable press and hold
        NSAutomaticCapitalizationEnabled = false;  # disable auto capitalization(自动大写)
        NSAutomaticDashSubstitutionEnabled = false;  # disable auto dash substitution(智能破折号替换)
        NSAutomaticPeriodSubstitutionEnabled = false;  # disable auto period substitution(智能句号替换)
        NSAutomaticQuoteSubstitutionEnabled = false;  # disable auto quote substitution(智能引号替换)
        NSAutomaticSpellingCorrectionEnabled = false;  # disable auto spelling correction(自动拼写检查)
        NSNavPanelExpandedStateForSaveMode = true;  # expand save panel by default(保存文件时的路径选择/文件名输入页)
        NSNavPanelExpandedStateForSaveMode2 = true;
      };
    };

    # keyboard settings is not very useful on macOS
    # the most important thing is to remap option key to alt key globally,
    # but it's not supported by macOS yet.
    keyboard = {
      enableKeyMapping = true;  # enable key mapping so that we can use `option` as `control`
      remapCapsLockToControl = false;  # remap caps lock to control
      remapCapsLockToEscape  = false;  # remap caps lock to escape
    };
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = false;
      # 'zap': uninstalls all formulae(and related files) not listed in the generated Brewfile
      cleanup = "zap";
    };

    # Applications to install from Mac App Store using mas.
    masApps = {
      # Xcode = 497799835;
    };

    taps = [
      "homebrew/cask"
      "homebrew/cask-fonts"
      "homebrew/services"
      "homebrew/cask-versions"

      "hashicorp/tap"
      "pulumi/tap"
    ];

    brews = [
      # `brew install`
      "wget"  # download tool
      "curl"  # no not install curl via nixpkgs, it's not working well on macOS!
      "aria2"  # download tool
      "httpie"  # http client
      "wireguard-tools"  # wireguard
      "tailscale"   # tailscale
    ];

    # `brew install --cask`
    casks = [
      # broser & editor
      "firefox"
      "google-chrome"
      "visual-studio-code"
      "visual-studio-code-insiders"

      # IM & audio & remote desktop & meeting
      "telegram"
      "discord"
      "wechat"
      "qq"
      "neteasemusic"
      "qqmusic"
      "microsoft-remote-desktop"
      "wechatwork"
      "tencent-meeting"

      # "anki"
      "clashx"    # proxy tool
      "iina"      # video player
      "openinterminal-lite"  # open current folder in terminal
      "syncthing"  # file sync
      "raycast"   # Alfred-like tool(search and run scripts)
      "iglance"   # beautiful system monitor
      "eudic"     # 欧路词典
      "baiduinput"  # baidu input method
      # "reaper"  # audio editor

      # Development
      "insomnia"  # REST client
      "wireshark"  # network analyzer
      "jdk-mission-control"  # Java Mission Control
      "google-cloud-sdk"  # Google Cloud SDK
    ];
  };
}
