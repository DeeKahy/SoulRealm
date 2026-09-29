---
tags:
  - resource
  - resource/haskell
---
# Haskell - Workspace Guide

Workflow for solving tasks and keeping them in the notes. Related: [[Lecture 1 - Intro to Functional Programming]], [[Haskell - Polymorphism Rule of Thumb]]

## Layout
- `haskell/` - the devenv (Nix) environment with GHC. Don't move it.
- `haskell/lectureNN/preparation.hs` (prep sheet) and `exercises.hs` - **solve tasks here** (one folder per lecture, one section per task with `-- ===== Task X =====` headers).
- `Notes/Lecture N - Haskell Exercises.md` - auto-generated note per lecture, holding all code from that folder.

## Workflow
1. In `haskell/`, run `devenv shell` (or use direnv).
2. Solve tasks in `lectureNN/exercises.hs`; test with `ghci file.hs` or `runghc file.hs`. Use `-- >>> expr` comments to record results.
3. Run `sync-notes` (or `bash sync-notes.sh`) to refresh the exercise notes.
4. New lecture: create `haskell/lecture14/` with your .hs files, then sync - a new note appears automatically.

Tip: keep the task text as comments above each solution so the note is self-contained.
