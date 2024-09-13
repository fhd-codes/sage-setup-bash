# Sage Setup Bash Script

A bash script to help you set up a Sage theme inside your simple WordPress setup (without Bedrock).

## Prerequisites

Make sure the following are installed before running the script:

- **npm**
- **Composer**
- **Git**
- **ACF Pro Plugin** (Available in your WordPress installation)

## How to Use

0. **Copy and paste this setup.sh file in the theme directory**

1. **Create a GitHub Repository:**
   - Create an empty repository on GitHub. The repository name should be the name of your theme.
   - For example, if your repository is named `my-theme`, the bash script will use this repo name and set the theme name as `My Theme`.

2. **Download/Clone the Bash Script:**
   - Download or clone this bash script and place it inside your WordPress theme folder:
     ```bash
     public/wp-content/themes
     ```

3. **Run the Bash Script:**
   - Execute the script in the terminal from the `themes` directory:
     ```bash
     ./setup-sage.sh
     ```

## Bash Script Workflow

1. **GitHub Repo URL:**
   - The script will prompt you for the GitHub repository URL. Copy and paste the theme repo URL you created earlier.
   
2. **Theme Setup:**
   - Once the basic Sage theme is set up, the script will ask for the theme developer’s name. It will use this information to update the `style.css` file.

3. **ACF Pro Plugin Installation:**
   - After the theme setup, the script will instruct you to install the ACF Pro plugin from the WordPress admin dashboard.
   - Press any key to continue with the setup.

Once the setup is complete, your Sage theme will be ready for use.

---

Enjoy building your theme with Sage!
