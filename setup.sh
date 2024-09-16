#!/bin/bash

# ==============================================================
# Checking if the required packages are installed or not
# ==============================================================
# Function to check if a package is installed
check_package() {
  if ! command -v $1 &> /dev/null; then
    echo "$1 is not installed. Exiting..."
    exit 1
  else
    echo "$1 is installed."
  fi
}

# List of packages to check
packages=("npm" "composer" "git" "wp")

# Loop through each package and check if it is installed
for package in "${packages[@]}"
do
  check_package $package
done

echo "All required packages are installed."
echo "---------------------------------------*********------------------"
echo "Make sure the the website is running on PHP 8.2 or greater version"
echo "---------------------------------------*********------------------"

echo "Press any key to continue"
read -rsn1


# ==============================================================
# Installing sage theme
# ==============================================================
# Asking user to enter github repo url.
echo "Enter the Git repository URL:"
read git_repo_url

# Keep asking for the theme name if it is an empty string.
while [[ -z "$git_repo_url" ]]; do
    echo "Please enter a git repo url SSH or HTTPS (it cannot be empty):"
    read git_repo_url
done

# Extracting the repo name.
repo_name=$(echo "$git_repo_url" | sed 's#.*/##' | sed 's/\.git$//')

# Converting the repo name to theme name (Sentence Case).
theme_name=$(echo "$repo_name" | sed 's/-/ /g' | awk '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) tolower(substr($i,2));}1')

composer create-project roots/sage "$repo_name"
echo "Sage theme installed.."

# Editing the style.css file and updating the theme name.
cd ./"$repo_name" || { echo "Theme directory not found. Exiting."; exit 1; }

# ==============================================================
# Updating theme files with latest available changes.
# ==============================================================
# Checking if the project setup is being done for the first time or not.
# NOTE: "first time setup" means that no other developer has worked on this repo before.
is_first_setup="./setup-log.txt"

if [[ ! -f "$is_first_setup" ]]; then
# If the project setup is being done for the first time.
# Creating this file so next time any developer setups the project,
# the style.css file should not be updated again. As it is already done.
touch setup-log.txt

cat <<EOT > setup-log.txt
DO NOT DELETE THIS FILE. 
This file looks useless. But it serves a special hidden purpose.
EOT

# Updating theme name and developer name in style.css file
echo "Enter theme developer's name:"
read theme_author

cat <<EOT > style.css
/*
Theme Name:         $theme_name
Description:        $theme_name - a WordPress Sage based theme.
Version:            1.0.0
Author:             $theme_author
Text Domain:        sage
*/
EOT

# TODO: Clone the boilerplate code here and merge the changes.
# TODO: Make the boilerplate repo first :/
fi

echo "Enter your sudo password"
sudo npm install
composer require roots/acorn
composer install

echo "*************************"
echo "Installing 'log1x/acf-composer'..."
echo "Make sure you go to wp-admin side and install ACF Pro plugin. Press any key to continue:"
read -rsn1

composer require log1x/acf-composer
wp acorn optimize:clear

# ==============================================================
# Initializing git and pulling the latest changes
# ==============================================================
git init

# Updating gitignore file.

git add .
git commit -m "initial theme setup done - Step 1"

git config pull.rebase false
git pull "$git_repo_url" --allow-unrelated-histories

git remote add origin "$git_repo_url"

cat <<EOT > .gitignore
/node_modules
/vendor
/public
.env
.budfiles
npm-debug.log
yarn-error.log
EOT

git add .
git commit -m "initial theme setup done - Step 2"

npm run build

# ==============================================================
# Wrapping up.
# ==============================================================
# building the latest changes
npm run build

echo "Theme setup completed."
echo "Git setup completed."
echo "Happy coding."
