Ubuntu Reinstallation
=====================

1. Make bootable Flash drive
   ```console
   sudo fdisk --list
   sudo dd bs=4M status=progress if=~/Downloads/ubuntu-22.04-desktop-amd64.iso of=/dev/sdX
   ```

1. Backup
    - Files
      ```console
      ./backup.sh
      git commit --all -m 'Backup home/root files'
      git push
      ```
    - SSH keys
      ```console
      zip --encrypt -j ssh.zip ~/.ssh/*
      ```
    - PyCharm
        - Settings sync or Export Settings
    - Sync Dropbox files
    - Sync Browser data
        
1. Install Ubuntu

1. [Bash-it](https://github.com/Bash-it/bash-it#installation)  
    Add to `~/.bashrc`
    ```console
    export BASH_IT_THEME='font'
    ```
   
    ```console
    git clone --depth=1 https://github.com/Bash-it/bash-it.git ~/.bash_it
    ~/.bash_it/install.sh --no-modify-config
   
    source ~/.bashrc
    ```

1. Config FS table
    ```console
    sudo mkdir /media/voronin/data
    #sudo chown dimka /media/voronin/data
    blkid
    sudo nano /etc/fstab
    mount --all
    ```

2. Update OS
    ```console
    sudo apt update
    sudo apt dist-upgrade
    ```

3. Swap file
    ```console
    swapon --show
    
    sudo fallocate /swapfile --length 1G
    sudo mkswap --check /swapfile
    sudo chmod u=rw,g=,o= /swapfile
    sudo swapon /swapfile

    swapon --show
    ```
   Write to `/etc/sysctl.conf`: `vm.swappiness=1`
   ```console
   sudo nano /etc/sysctl.conf
   sudo sysctl --load
   cat /proc/sys/vm/swappiness
   ```
   
4. Install OS packages
    ```console
    sudo apt install -y ubuntu-restricted-extras vlc
    sudo apt install -y build-essential git
    ```

5. Python
    ```console
    sudo apt install -y python3-dev python3-pip
    sudo python3 -m pip install -U pip setuptools wheel 
    
    python3 -m pip install --user -U pipx
    pipx install cookiecutter poetry pipenv==2022.1.8
    ```
    
6. Pyenv
    Install [pyenv](https://github.com/pyenv/pyenv#installation)
    (e.g. using [pyenv-installer](https://github.com/pyenv/pyenv-installer#installation--update--uninstallation))
    
6. Node.js
    Install [nvm](https://github.com/nvm-sh/nvm#installing-and-updating)
    ```console
    nvm install --lts --latest-npm
    ```

4. Install Lua (not updated)
    - Install Lua and luarocks (1 of 2):
        * `sudo apt install -y lua5.3 liblua5.3-dev`  
          Install [luarocks](https://google.com/search?q=luarocks+install)
          
        * `sudo apt install -y luarocks`
    - [Löve](https://google.com/search?q=love2d+install)  
    - [ZeroBrane Studio](https://studio.zerobrane.com/download)
      ```console
      ./restore.sh copy ~/.zbstudio/user.lua
      ```

4. PyCharm  
    [Search](https://google.com/search?q=download+pycharm)
    - Community edition
        ```console
        sudo snap install pycharm-community
        # Don't update. It crashes non-updated plugins
        snap refresh --hold pycharm-community
        ```
    - Professional edition  
        ```console
        sudo snap install pycharm-professional
        ```
            
    Turn off Gnome hot keys
    ```console
    # Alt+F1: Main menu                 Select in
    gsettings set org.gnome.desktop.wm.keybindings panel-main-menu []
    
    # Alt+F7: Begin move                Find usages
    gsettings set org.gnome.desktop.wm.keybindings begin-move []
    
    # Alt+F8: Begin resize              Evaluate expression
    gsettings set org.gnome.desktop.wm.keybindings begin-resize []

    # Ctrl+Alt+Arrow: Switch workspace  Navigation
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up []
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down []
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left []
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right []

    # Ctrl+Alt+S: Window toggle shaded  Settings
    gsettings set org.gnome.desktop.wm.keybindings toggle-shaded []
    ```

7. Install Gnome Shell extensions
    - `sudo apt install -y chrome-gnome-shell`
    - [Hide Top Panel](https://extensions.gnome.org/extension/740/hide-top-panel/)
    - [Suspend Button](https://extensions.gnome.org/extension/826/suspend-button/)

8. Install programs
    - Search [Google Chrome](https://google.com/search?q=google+chrome+install+linux)
        or alternatively:
        ```console
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output-document=google-chrome.deb
        sudo dpkg -i google-chrome.deb
        rm google-chrome.deb
        ```
    - Search [DeaDBeeF](https://google.com/search?q=deadbeef+install)

9. Dropbox
  - [Install Dropbox](https://google.com/search?q=dropbox+install)
      or alternatively:
      ```console
      sudo apt install -y nautilus-dropbox
      ```

10. Install NVidia driver
    ```console
    ubuntu-drivers devices
    sudo add-apt-repository ppa:ubuntu-x-swat/x-updates && sudo apt update
    sudo apt install nvidia-340 nvidia-settings
    sudo nvidia-xconfig
    ```
    Restart OS


12. Gnome Settings
    ```console
    gsettings list-recursively | grep ""

    # Switch language by Ctrl+Space
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Ctrl>space']"
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward []
    
    # Set Compose key
    # check before setting:
    gsettings get org.gnome.desktop.input-sources xkb-options
    gsettings set org.gnome.desktop.input-sources xkb-options [\'compose:caps\']

    # Workspaces
    gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
    gsettings set org.gnome.shell.overrides dynamic-workspaces false
    gsettings set org.gnome.mutter dynamic-workspaces false

    # Nautilus
    # gsettings set org.gnome.nautilus.preferences sort-directories-first true
    gsettings set org.gnome.nautilus.preferences default-sort-order name
    gsettings set org.gnome.nautilus.preferences default-folder-viewer list-view
    ```

13. Gnome Shell Extensions
    ```console
    sudo apt install gnome-shell-extension-manager
    ```
    Run `Extension Manager`
    
    - Install `Bring Out Submenu Of Power Off/Logout Button` extension
      Arrange Menu Items Order: [1, 2, 3, 9, __7__, 4, 5, 10, 6, 8]
    
    - Install `Dash to panel` extension
    
      `Position` tab
      - Panel screen position: `Left`
      - Show Application buttons: uncheck `Visible`
      - Desktop button: uncheck `Visible`
      
      `Style` tab
      - App icon margin: `0`      

      `Behavior` tab
      - Ungroup applications: `Checked`  
        `Gear`
        - Maximum width (px) of application titles: `80`
        - Display running indicators on unfocused applications: `False`
