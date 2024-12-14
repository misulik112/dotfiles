import subprocess
import os
import logging

# Enable command tracing
DEBUG = True

# Configure logging
logging.basicConfig(
    level=logging.DEBUG if DEBUG else logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
)


def is_installed(package):
    """Check if a package is installed using pacman"""
    result = subprocess.run(
        ["pacman", "-Qq", package], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
    )
    return result.returncode == 0


def install_package(package):
    """Install a package using pacman"""
    subprocess.run(["sudo", "pacman", "-S", "--noconfirm", package])


def install_tmux():
    if not is_installed("tmux"):
        print(f"Installing TMUX")
        install_package("tmux")
    else:
        print("Installing TMUX pluging")
        subprocess.run(
            [
                "git",
                "clone",
                "https://github.com/tmux-plugins/tpm",
                "~/.tmux/plugins/tpm",
            ]
        )


def main():
    packages = [
        "ttf-sourcecodepro-nerd",
        "ttf-nerd-fonts-symbols",
        "ttf-nerd-fonts-symbols-mono",
        "ttf-mononoki-nerd",
        # Apps
        "tree",
        "lazygit",
        "github-cli",
        "python-pynvim",
        "npm",
        "neovim",
        "obsidian",
        "syncthing",
    ]

    for package in packages:
        if not is_installed(package):
            print(f"Installing {package}...")
            install_package(package)
        else:
            print(f"{package} is already installed. Skipping...")


if __name__ == "__main__":
    main()
    install_tmux()
