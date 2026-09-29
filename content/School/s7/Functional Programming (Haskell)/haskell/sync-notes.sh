#!/usr/bin/env bash
# Regenerates one Obsidian note per lectureN/ folder from its .hs files.
# Edit/solve in the .hs files (run with ghci/runghc via devenv), then run this
# (or `sync-notes` inside the devenv shell) to refresh the notes.
set -euo pipefail
cd "$(dirname "$0")"
notes="../Notes"
mkdir -p "$notes"
for dir in lecture*/; do
  dir=${dir%/}
  n=$((10#${dir#lecture}))
  out="$notes/Lecture $n - Haskell Exercises.md"
  {
    echo "---"
    echo "tags:"
    echo "  - resource"
    echo "  - resource/haskell"
    echo "  - resource/exercises"
    echo "---"
    echo "# Lecture $n - Haskell Exercises"
    echo
    echo "> Auto-generated from \`haskell/$dir/*.hs\` by \`sync-notes.sh\` - edit the .hs files, not this note."
    echo
    echo "Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]"
    for f in "$dir"/preparation.hs $(ls "$dir"/*.hs | grep -v preparation.hs); do
      [ -e "$f" ] || continue
      echo
      echo "## $(basename "$f")"
      echo
      echo '```haskell'
      cat "$f"
      echo
      echo '```'
    done
  } > "$out"
  echo "wrote $out"
done
