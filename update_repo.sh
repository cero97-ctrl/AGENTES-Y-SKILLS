#!/usr/bin/env bash
set -euo pipefail

# update_repo.sh
# Usage:
#   ./update_repo.sh [-d DIR] [-r REMOTE] [-b BRANCH] [-m "commit message"] [--push] [--no-pull] [--dry-run]
# Examples:
#   ./update_repo.sh                    # pull current branch, add/commit changes with default message and push
#   ./update_repo.sh -d /path/to/repo -m "Fix docs" --push
#   ./update_repo.sh --no-pull --push  # don't pull, just commit and push local changes

REMOTE="origin"
BRANCH=""
DIR="$(pwd)"
COMMIT_MSG="Update from update_repo.sh"
DO_PUSH=false
DO_PULL=true
DRY_RUN=false

show_help(){
  sed -n '1,120p' "$0" | sed -n '1,40p'
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -d|--dir)
      DIR="$2"; shift 2;;
    -r|--remote)
      REMOTE="$2"; shift 2;;
    -b|--branch)
      BRANCH="$2"; shift 2;;
    -m|--message)
      COMMIT_MSG="$2"; shift 2;;
    --push)
      DO_PUSH=true; shift;;
    --no-pull)
      DO_PULL=false; shift;;
    --dry-run)
      DRY_RUN=true; shift;;
    -h|--help)
      show_help; exit 0;;
    *)
      echo "Unknown argument: $1"; show_help; exit 1;;
  esac
done

echo "Dir: $DIR"
echo "Remote: $REMOTE"

cd "$DIR"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: $DIR is not a git repository." >&2
  exit 2
fi

CURRENT_BRANCH=$(git symbolic-ref --quiet --short HEAD || git rev-parse --short HEAD)
if [ -z "$BRANCH" ]; then
  BRANCH="$CURRENT_BRANCH"
fi

echo "Branch: $BRANCH"

if [ "$DRY_RUN" = true ]; then
  echo "DRY RUN: no changes will be made. Showing planned actions..."
  echo "Would run: git fetch $REMOTE"
  if [ "$DO_PULL" = true ]; then
    echo "Would run: git pull --rebase $REMOTE $BRANCH"
  fi
  echo "Would run: git add -A"
  echo "Would run: git commit -m \"$COMMIT_MSG\" (if there are changes)"
  if [ "$DO_PUSH" = true ]; then
    echo "Would run: git push $REMOTE $BRANCH"
  fi
  exit 0
fi

# Fetch and pull
echo "Fetching from $REMOTE..."
git fetch "$REMOTE"

if [ "$DO_PULL" = true ]; then
  echo "Pulling latest from $REMOTE/$BRANCH (rebase)..."
  git pull --rebase "$REMOTE" "$BRANCH" || {
    echo "Pull failed: you may need to resolve conflicts manually." >&2
    exit 3
  }
fi

# Stage changes
if git status --porcelain | grep -q .; then
  echo "Staging changes..."
  git add -A
  # commit if there are staged changes
  if ! git diff --cached --quiet; then
    echo "Committing with message: $COMMIT_MSG"
    git commit -m "$COMMIT_MSG" || {
      echo "Commit failed." >&2
      exit 4
    }
  else
    echo "No staged changes to commit."
  fi
else
  echo "No local changes detected."
fi

if [ "$DO_PUSH" = true ]; then
  echo "Pushing to $REMOTE $BRANCH..."
  git push "$REMOTE" "$BRANCH"
fi

echo "Done."
