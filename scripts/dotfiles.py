import os
import subprocess

dotfiles_folder = os.path.expanduser("~/dotfiles")


def start_tmux_session(dotfiles_folder):
    # Command to start a new tmux session and change to the dotfiles folder
    command = f"tmux new-session -s dotfiles -c {dotfiles_folder}"
    subprocess.run(command, shell=True)


if __name__ == "__main__":
    start_tmux_session(dotfiles_folder)
