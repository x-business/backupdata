#!/bin/bash

# Replace this with your repository URL and directory
REPO_URL=".git"
REPO_DIR="."

# Clone the repository if not already cloned
if [ ! -d "$REPO_DIR" ]; then
  git clone "$REPO_URL" "$REPO_DIR"
fi

# Navigate to the repository directory
cd "$REPO_DIR"

# Get the first commit date and email of each user
git log --pretty=format:'%ae %aI' --reverse | awk '
{
    email = $1;
    date = $2;
    if (!(email in first_commit_date)) {
        first_commit_date[email] = date;
    }
}
END {
    for (email in first_commit_date) {
        if (first_commit_date[email] >= "2018-01-01T00:00:00" && first_commit_date[email] <= "2018-02-28T23:59:59") {
            print email;
        }
    }
}
'