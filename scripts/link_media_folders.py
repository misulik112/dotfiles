import os
from pathlib import Path

# Define original directories and target locations
original_dirs = {
    "Music": Path.home() / "Music",
    "Videos": Path.home() / "Videos",
    "Projects": Path.home() / "Projects",
    "Documents": Path.home() / "Documents",
}
target_dirs = {
    "Music": "/mnt/diverse/Music",
    "Videos": "/mnt/diverse/Videos",
    "Projects": "/mnt/diverse/Projects",
    "Documents": "/mnt/diverse/Documents",
}


def remove_and_link(original_path, target_path):
    try:
        # Remove the original directory or symlink if it exists
        if original_path.is_symlink() or original_path.exists():
            if original_path.is_symlink():
                os.unlink(original_path)  # Remove symlink
            elif original_path.is_dir():
                import shutil

                shutil.rmtree(original_path)  # Remove directory and its contents
            else:
                os.remove(original_path)  # Handle other cases like regular files

        # Create a symbolic link to the target directory
        os.symlink(target_path, original_path, target_is_directory=True)
        print(f"Created symlink: {original_path} -> {target_path}")
    except Exception as e:
        print(f"Error processing {original_path}: {e}")


# Process each directory
for key in original_dirs:
    remove_and_link(original_dirs[key], target_dirs[key])
