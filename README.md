Config Ubuntu GNOME after install
=================================

0. **Before OS install**
    - Keep files
        - `.ssh/`
        - `.PyCharmYYYY.N/`
        
1. Install OS

2. Update OS
    ```console
    sudo apt-get update && sudo apt-get dist-upgrade
    ```

3. Create swap file
    ```console
    sudo fallocate /swap --length 1G
    sudo mkswap --check /swap
    sudo chmod u=rw,g=,o= /swap
    sudo swapon /swap

    swapon --show
    ```

4. Install packages
    ```console
    sudo apt-get install -y aptitude

    sudo aptitude install -y ubuntu-restricted-extras
    sudo aptitude install -y vlc

    sudo aptitude install -y flac cuetools shntool      # Splitting FLAC
    ```

5. Install dev packages
    ```console
    sudo aptitude install -y git

    sudo aptitude install -y python-dev
    sudo aptitude install -y python-pip

    sudo aptitude install -y python3-dev
    sudo aptitude install -y python3-pip

    sudo pip3 install -U virtualenvwrapper

    sudo pip install -U ansible

    # install Renamer dependency
    sudo pip3 install mutagen
    ```
    
6. Install [pyenv](https://github.com/pyenv/pyenv)
    [https://github.com/pyenv/pyenv-installer](https://github.com/pyenv/pyenv-installer#installation--update--uninstallation)

6. Install `pipenv`
    ```commandline
    sudo pip install --user pipenv
    ```

7. Install Gnome Shell extensions
    - `sudo aptitude install -y chrome-gnome-shell`
    - [Hide Top Panel](https://extensions.gnome.org/extension/740/hide-top-panel/) extension page
    - [Suspend Button](https://extensions.gnome.org/extension/826/suspend-button/) extension page 

8. Install programs
    - Google [Google Chrome](https://google.com/search?q=google+chrome+install+linux)
        or alternatively:
        ```console
        wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb --output-document=google-chrome.deb
        sudo dpkg -i google-chrome.deb
        rm google-chrome.deb
        ```
    - Google [DeaDBeeF](https://google.com/search?q=deadbeef+install)
    - Google [Dropbox](https://google.com/search?q=deadbeef+install)
        or alternatively:
        ```console
        sudo aptitude install -y nautilus-dropbox
        ```
    - Google [PyCharm](https://google.com/search?q=pycharm+install)  
        Put to `~/pycharm/`. **We will use it to merge configs.**  
        Run:
        ```console
        ~/pycharm/bin/pycharm.sh
        ```

9. Uninstall packages
    ```console
    # Video player
    sudo aptitude purge -y totem totem-plugins

    # Audio player
    sudo aptitude purge -y rhythmbox rhythmbox-plugins rhythmbox-data

    # BitTorrent client
    sudo aptitude purge -y transmission transmission-common transmission-gtk

    # E-mail client
    sudo aptitude purge -y evolution evolution-plugins

    # Messenger
    sudo aptitude purge -y empathy mcp-account-manager-goa

    # Photo manager
    sudo aptitude purge -y gnome-photos

    # CD Burner
    sudo aptitude purge -y brasero brasero-cdrkit

    # Music manager
    sudo aptitude purge -y gnome-music

    # Take pictures from webcam
    sudo aptitude purge -y cheese cheese-common

    # Calendar
    sudo aptitude purge -y gnome-calendar

    # Solitaire, Games
    sudo aptitude purge -y aisleriot gnome-sudoku gnome-mines gnome-mahjongg

    # Maps
    sudo aptitude purge -y gnome-maps
    
    # Simple Scan
    sudo aptitude purge -y simple-scan    
    
    # Screen Reader
    sudo aptitude purge -y gnome-orca    
    ```

10. Install NVidia driver
    ```console
    ubuntu-drivers devices

    sudo add-apt-repository ppa:ubuntu-x-swat/x-updates && sudo aptitude update

    sudo aptitude install nvidia-XXX nvidia-settings

    sudo nvidia-xconfig
    ```
   Restart OS

11. Config FS table
    ```console
    sudo mkdir /media/e /media/data
    #sudo chown dimka /media/e /media/data

    blkid

    sudo ~/pycharm/bin/pycharm.sh merge fstab /etc/fstab /etc/fstab

    mount --all
    ```

12. Config Gnome Shell
    ```console
    gsettings list-recursively | grep "<Ctrl><Alt>"

    # Switch language by <Ctrl>Space
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward []
    gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Control>Space']"

    # Workspaces
    gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
    gsettings set org.gnome.shell.overrides dynamic-workspaces false

    # Favorite apps
    gsettings set org.gnome.shell favorite-apps "['google-chrome.desktop', 'jetbrains-pycharm.desktop', 'nautilus.desktop', 'gnome-terminal.desktop']"

    # Gedit
    gsettings set org.gnome.gedit.preferences.editor create-backup-copy false

    # Nautilus
    gsettings set org.gnome.nautilus.preferences sort-directories-first true
    gsettings set org.gnome.nautilus.preferences default-sort-order name
    gsettings set org.gnome.nautilus.preferences default-folder-viewer list-view
    ```
    
12. Turn off Gnome hotkeys
    ```commandline
    # <Alt>LMB: Move window -> PyCharm Multicursor <Shift><Alt>LMB
    gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier ""

    # <Alt>F7: Move window -> PyCharm Find usages
    gsettings set org.gnome.desktop.wm.keybindings begin-move []

    # <Ctrl><Alt>Arrow: Switch workspace -> PyCharm Navigation
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up []
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down []
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-left []
    gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-right []

    # <Ctrl><Alt>S: Window toggle shaded -> PyCharm Settings
    gsettings set org.gnome.desktop.wm.keybindings toggle-shaded []
    ```

13. Config Nautilus
    ```console
    touch ~/Templates/Text.txt

    wget https://github.com/dimka665/ubuntu-gnome/raw/master/files/Rename --output-document=~/.local/share/nautilus/scripts
    chmod a+x ~/.local/share/nautilus/scripts/Rename
    ```

14. Config Git
    ```console
    wget https://github.com/dimka665/ubuntu-gnome/raw/master/files/.gitconfig -O git-config

    ~/pycharm/bin/pycharm.sh merge git-config ~/.gitconfig ~/.gitconfig
    ```

15. Config sysctl
    ```console
    wget https://github.com/dimka665/ubuntu-gnome/raw/master/files/sysctl.conf
    sudo ~/pycharm/bin/pycharm.sh merge sysctl.conf /etc/sysctl.conf /etc/sysctl.conf

    sudo sysctl --load
    ```

16. Config auto update



Feature
-------

Google Chrome cache. More and in RAM
Sleep time
