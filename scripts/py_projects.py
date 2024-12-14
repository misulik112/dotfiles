import os
import subprocess


def list_project_folders():
    projects_folder = os.path.expanduser("~/Projects")

    if not os.path.exists(projects_folder):
        os.makedirs(projects_folder)
        print(f"Created '{projects_folder}' folder.")

    return [
        f
        for f in os.listdir(projects_folder)
        if os.path.isdir(os.path.join(projects_folder, f))
    ]


def select_project_folder(project_folders):
    if not project_folders:
        print("No projects found. Creating a new one...")
        create_new_project()
        return

    print("Select a project or create a new one:")
    for i, folder in enumerate(project_folders, start=1):
        print(f"{i}. {folder}")
    print(f"{len(project_folders) + 1}. Create a new project")

    try:
        selection = int(input("Enter the number of your choice: "))
        if selection == len(project_folders) + 1:
            create_new_project()
        elif 1 <= selection <= len(project_folders):
            selected_folder = os.path.join(
                os.path.expanduser("~/Projects"), project_folders[selection - 1]
            )
            print(f"Selected project: {selected_folder}")
            start_tmux_session(selected_folder)
        else:
            print("Invalid selection.")
    except ValueError:
        print("Invalid selection.")


def create_new_project():
    project_name = input("Enter the name of the new project: ")
    new_project_folder = os.path.expanduser(f"~/Projects/{project_name}")

    if os.path.exists(new_project_folder):
        print(f"The project '{project_name}' already exists.")
        return

    os.makedirs(new_project_folder)
    print(f"Created new project '{project_name}' at '{new_project_folder}'.")

    create_virtualenv(new_project_folder)
    start_tmux_session(new_project_folder)


def create_virtualenv(project_folder):
    subprocess.run(["python", "-m", "venv", os.path.join(project_folder, ".venv")])
    print(f"Created virtual environment in '{os.path.join(project_folder, '.venv')}'.")


def start_tmux_session(project_folder):
    project_name = os.path.basename(project_folder)
    subprocess.run(["tmux", "new-session", "-s", project_name, "-c", project_folder])
    print(f"Started tmux session '{project_name}' in '{project_folder}'.")


if __name__ == "__main__":
    project_folders = list_project_folders()
    select_project_folder(project_folders)
