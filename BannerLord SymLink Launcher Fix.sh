#!/bin/bash
FILE=.local/share/Steam/steamapps/common/"Mount & Blade II Bannerlord"/bin/Win64_Shipping_Client/TaleWorlds.MountAndBlade.Launcher.exe.backup
#Functions
restore() {
        rm -f TaleWorlds.MountAndBlade.Launcher.exe
        mv TaleWorlds.MountAndBlade.Launcher.exe.backup TaleWorlds.MountAndBlade.Launcher.exe
} 

createsymlink() {
        mv TaleWorlds.MountAndBlade.Launcher.exe TaleWorlds.MountAndBlade.Launcher.exe.backup
        ln -s Bannerlord.Native.exe TaleWorlds.MountAndBlade.Launcher.exe
}

# Ask the user for their decision
echo "Enter 1 for Enabling the Symlink or enter 2 to Undo the Symlink"
read usrchoice
case $usrchoice in
  1)
    if [ -f "$FILE" ]; then
      cd .local/share/Steam/steamapps/common/"Mount & Blade II Bannerlord"/bin/Win64_Shipping_Client
      echo "a backup of your launcher was previously completed, continuing would overwrite that backup with a new backup"
      echo "Enter 1 if the game was recently updated or enter 2 to restore backup and recreate the symlink"
      read existingbakchoice
      case $existingbakchoice in
        1)
          createsymlink
          echo "Completed the symlink and created backup of the updated launcher for this latest version"
          ;;
        2)
          restore
          createsymlink
          echo "Restored the launcher, created backup of it and then re-created symlink"
          ;;
        *)
          echo "Invalid selection"
          ;;
      esac
    else 
      cd .local/share/Steam/steamapps/common/"Mount & Blade II Bannerlord"/bin/Win64_Shipping_Client
      createsymlink
      echo "Completed the symlink"
    fi
    ;;
  2)
    cd .local/share/Steam/steamapps/common/"Mount & Blade II Bannerlord"/bin/Win64_Shipping_Client
    restore
    echo "Removed the symlink and restored original files"
    ;;
  *)
    echo "Invalid selection"
    ;;
esac
