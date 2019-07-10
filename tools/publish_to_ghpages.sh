
#!/bin/sh

# DIR=$(dirname "$1")
# echo "$DIR"

cd ~/sandboxLocal/cloudbox.ga
echo -n "working dir: "
pwd
# echo "working dir: $(dirname $0)"

if [[ $(git status -s) ]]
then
    echo "The working directory is dirty. Please commit any pending changes."
    exit 1;
fi

echo "Deleting old publication"
rm -rvf public
mkdir public
git worktree prune
rm -rvf .git/worktrees/public/

echo "Checking out gh-pages branch into public"
git worktree add -B gh-pages public origin/gh-pages

echo "Removing existing files"
rm -rvf public/*

echo "Generating site"
hugo

echo "Updating gh-pages branch"
cd public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)"
git push
