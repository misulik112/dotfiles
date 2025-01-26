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


def main():
    packages = [
        # Apps
        "tree",
        "lazygit",
        "github-cli",
        "python-pynvim",
        "npm",
        "neovim",
        "tmux",
        "wget",
        "calibre",
        "ffmpeg",
        "tk",
    ]

    for package in packages:
        if not is_installed(package):
            print(f"Installing {package}...")
            install_package(package)
        else:
            print(f"{package} is already installed. Skipping...")


if __name__ == "__main__":
    main()
