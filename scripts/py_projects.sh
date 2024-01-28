#!/bin/bash

projects_dir="$HOME/Projects/Python"

# Check if Projects directory exists
if [ ! -d "$projects_dir" ]; then
	echo "Projects directory not found."
	exit 1
fi

# Change to Projects directory
cd "$projects_dir" || exit

# List available projects
echo "Available projects:"
projects=($(ls -d */))
num_projects=${#projects[@]}

for ((i = 0; i < num_projects; i++)); do
	echo "$((i + 1)). ${projects[i]}"
done

# Ask user for project number
read -p "Enter the number of the project you want to move to: " project_num

# Check if project number is valid
if ! [[ "$project_num" =~ ^[0-9]+$ ]]; then
	echo "Invalid input. Please enter a number."
	exit 1
elif ((project_num < 1 || project_num > num_projects)); then
	echo "Invalid project number."
	exit 1
fi

# Get selected project name
selected_project="${projects[project_num - 1]}"

# Move to project directory
cd "$selected_project" || exit

# Print current directory
echo "You are now in: $(pwd)"

# Check if project has a virtual environment
if [ -d "venv" ]; then
	# Activate virtual environment
	source venv/bin/activate
	echo "Activated virtual environment 'venv'."
elif [ -d ".venv" ]; then
	# Activate virtual environment
	source .venv/bin/activate
	echo "Activated virtual environment '.venv'."
else
	echo "No virtual environment found."
fi

# Open tmux in the project directory
tmux new-session -s "$selected_project"
