# Dotfiles Management with GNU Stow

This repository contains my personal configuration files (dotfiles) managed using **GNU Stow**.

---

## **Installation**

### **1. Install GNU Stow**
GNU Stow is a symlink manager that helps keep dotfiles organized.

```bash
sudo apt update && sudo apt install stow -y
```

### **2. Clone the Repository**
```bash
git clone git@github.com:yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

---

## **Organizing Dotfiles**
Each application's configuration is stored in a separate folder inside `~/dotfiles`.

### **Example Directory Structure:**
```
~/dotfiles/
  ├── bash/
  │   └── .bashrc
  ├── vim/
  │   └── .vimrc
  ├── git/
  │   └── .gitconfig
  ├── nvim/
  │   └── .config/nvim/init.lua
  ├── alacritty/
  │   └── .config/alacritty/alacritty.yml
  ├── i3/
  │   └── .config/i3/config
```

---

## **Using GNU Stow**

### **1. Stow a Configuration**
To create symlinks from `~/dotfiles` to the home directory:

```bash
stow bash
stow vim
stow git
stow nvim
stow alacritty
stow i3
```

This will symlink:
- `~/dotfiles/bash/.bashrc` → `~/.bashrc`
- `~/dotfiles/vim/.vimrc` → `~/.vimrc`
- `~/dotfiles/nvim/.config/nvim/` → `~/.config/nvim/`

### **2. Verify Symlinks**
Check if the symlinks are correctly created:

```bash
ls -l ~/.bashrc ~/.vimrc ~/.gitconfig ~/.config/nvim
```

### **3. Remove a Symlinked Configuration**
To remove symlinks but **keep the files**, use:

```bash
stow -D bash
stow -D vim
```

### **4. Fix Conflicts**
If Stow warns about existing files, delete them first:

```bash
rm -rf ~/.bashrc ~/.vimrc ~/.gitconfig ~/.config/nvim
```

Then re-run:

```bash
stow bash
stow vim
stow git
stow nvim
```

---

## **Tracking Dotfiles with Git**

### **1. Initialize Git Repository**
```bash
cd ~/dotfiles
git init
git add .
git commit -m "Initial commit of dotfiles"
```

### **2. Push to GitHub**
```bash
git remote add origin git@github.com:yourusername/dotfiles.git
git push -u origin main
```

### **3. Restoring Dotfiles on a New Machine**
On a fresh install, restore your setup with:

```bash
git clone git@github.com:yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
stow bash
stow vim
stow git
stow nvim
stow alacritty
stow i3
```

---

## **Handling Git Submodules**
If a folder (e.g., `nvim/.config/nvim/`) is an **embedded Git repository**, remove its `.git` directory or use Git submodules.

### **Option 1: Remove Embedded Git Repo (Recommended)**
```bash
rm -rf ~/dotfiles/nvim/.config/nvim/.git
```

### **Option 2: Use a Git Submodule**
```bash
git rm --cached nvim/.config/nvim
git submodule add <nvim-repo-url> nvim/.config/nvim
git commit -m "Added Neovim as a submodule"
```

When cloning your dotfiles later:
```bash
git clone --recursive <your-dotfiles-repo-url>
git submodule update --init --recursive
```

---

## **Automating Setup with a Script**
Create `setup.sh` to automatically apply all symlinks:

```bash
nano ~/dotfiles/setup.sh
```

Paste this:

```bash
#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"
cd "$DOTFILES_DIR" || exit

for folder in */; do
    stow "${folder%/}"
done

echo "Dotfiles have been successfully linked!"
```

Save and run:
```bash
chmod +x ~/dotfiles/setup.sh
./setup.sh
```

---

## **Done! 🎉**
Your dotfiles are now neatly managed using GNU Stow. 🚀

