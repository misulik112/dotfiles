# **Dotfiles Management Script**

This script automates the management of dotfiles using **GNU Stow**. It backs up existing configuration files, removes them from their original locations, and creates symbolic links to a centralized dotfiles directory. Additionally, it allows you to exclude specific folders from being processed.

---

## **Features**

- Automatically backs up existing dotfiles to a timestamped backup directory.
- Removes old configuration files and replaces them with symbolic links managed by GNU Stow.
- Supports ignoring specific folders (e.g., scripts, templates, or other non-configuration directories).
- Handles nested directory structures and skips empty directories.
- Skips symlinks to avoid breaking existing configurations.

---

## **Requirements**

1. **GNU Stow**: Ensure GNU Stow is installed on your system. You can install it using your package manager:

   ```bash
   # On Debian/Ubuntu
   sudo apt install stow
   
   # On Fedora
   sudo dnf install stow
   
   # On Arch Linux
   sudo pacman -S stow
   ```

2. A properly structured dotfiles directory (see below for structure).

---

## **Directory Structure**

Your dotfiles should be organized in a way that mirrors their intended locations in your home directory. For example:

```
dotfiles/
├── alacritty/
│   └── .config/alacritty/alacritty.yml
├── zsh/
│   └── .zshrc
├── nvim/
│   └── .config/nvim/init.vim
├── scripts/           # Ignored folder (example)
└── templates/         # Ignored folder (example)
```

Each subdirectory (e.g., `alacritty`, `zsh`, `nvim`) represents a "package" for GNU Stow.

---

## **How to Use**

### **1. Place the Script in Your Dotfiles Directory**

Save the script as a file (e.g., `manage_dotfiles.sh`) in the root of your dotfiles repository.

### **2. Make the Script Executable**

Run the following command to make the script executable:

```bash
chmod +x manage_dotfiles.sh
```

### **3. Run the Script**

Execute the script from your dotfiles directory:

```bash
./manage_dotfiles.sh
```

The script will:

1. Create a backup of existing configuration files in a timestamped directory (e.g., `~/dotfiles_backup_YYYYMMDD_HHMMSS`).
2. Remove old configuration files from their original locations.
3. Create symlinks for all non-ignored folders using GNU Stow.

---

## **Customizing the Script**

### **Ignoring Folders**

To exclude specific folders from being processed by GNU Stow, add them to the `ignore_folders` array in the script:

```bash
ignore_folders=(
  "scripts"
  "templates"
  "docs"
)
```

### **Backup Directory**

Backups are stored in a directory named `dotfiles_backup_YYYYMMDD_HHMMSS` in your home directory. You can change this location by modifying the `BACKUP_DIR` variable:

```bash
BACKUP_DIR="$HOME/custom_backup_location"
```

---

## **Example Output**

When you run the script, you will see output like this:

```
Backed up and removed: .config/alacritty/alacritty.yml
Stowed alacritty
Ignored scripts
Ignored templates
Dotfiles have been backed up to /home/user/dotfiles_backup_20250103_180000 and new symlinks created with Stow, excluding specified folders.
```

---

## **Best Practices**

1. **Version Control**: Keep your dotfiles repository under version control (e.g., Git) so you can track changes and sync across systems.
2. **Dry Runs**: Test GNU Stow commands with the `-n` flag before running the script to ensure correct behavior:

   ```bash
   stow -n alacritty
   ```

3. **Test on New Systems**: Before running this script on a new system, ensure that your dotfiles repository is properly structured and that no critical files will be overwritten.

---

## **Troubleshooting**

### **Error: "Existing target is not owned by stow"**

This error occurs when a file or directory already exists at the target location but was not created by GNU Stow. The script addresses this issue by backing up and removing such files before creating symlinks.

### **Symlinks Not Working**

Ensure that GNU Stow is installed and that your dotfiles are organized correctly. Check symlinks with:

```bash
ls -l ~/.config/alacritty
```

### **Permission Issues**

If the script fails due to permission errors, ensure you have write access to your home directory and any relevant configuration paths.

---

## **License**

This script is provided as-is under an open-source license (MIT or similar). Feel free to modify it for your own use!

---
