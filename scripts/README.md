# Scripts

Run all scripts from the repository root.

---

## sync_claude_code_config.sh

Regenerates the Claude Code config from the master source (`AGENTS.md` + `.agents/skills/`).

**When to run:** After any change to `AGENTS.md` or `.agents/skills/` while you are using **Claude Code** and need an up-to-date local `CLAUDE.md` and `.claude/skills/` mirror (add, remove, or update skills or agent instructions).

**Keeping the mirror fresh matters more than tearing it down.** A stale `CLAUDE.md` or `.claude/skills/` is the real hazard, so run this sync after every change to the master files if you use Claude Code.

**Cursor users:** Cursor only loads the Claude and Codex trees when **Settings → Rules, Skills, Subagents → Include third-party Plugins, Skills, and other configs** is enabled. Turn that **off** and Cursor reads just the master files while Claude Code keeps its local mirror — no teardown needed. Note the toggle is all-or-nothing: it also gates Claude hooks and other third-party imports, not only `CLAUDE.md` and `.claude/skills/`. With the toggle on, both rule sets load together and roughly double the base rule context; `./scripts/delete_claude_code_config.sh` is then one way to avoid that, but it is optional.

**What it does:**

- Preserves existing Claude Code settings files under `.claude/`
- Removes and fully regenerates only `.claude/skills/`
- Copies all skills from `.agents/skills/` to `.claude/skills/`
- Rewrites copied skill markdown so internal `.agents/skills` references point at `.claude/skills/`
- Writes `CLAUDE.md` from `AGENTS.md` with skill paths rewritten for `.claude/skills/` (same body as the master file; workflow docs stay in `README.md` / `scripts/README.md`)

```bash
./scripts/sync_claude_code_config.sh
```

---

## delete_claude_code_config.sh

Removes the **generated** Claude Code files. Optional cleanup — nothing depends on it.

**When to run:** When you no longer need the local Claude Code mirrors on disk, or when you want Cursor to see only the master files and prefer not to use Cursor's own third-party-config toggle (see `sync_claude_code_config.sh` above).

**What it removes:**

- `CLAUDE.md`
- `CLAUDE.local.md` (if present)
- `.claude/skills/` (entire directory)

**What it keeps:** Any other files under `.claude/` (for example `settings.json` or hooks you maintain there).

To recreate the Claude Code layout after edits to the master source, run `./scripts/sync_claude_code_config.sh` again.

```bash
./scripts/delete_claude_code_config.sh
```

---

## setup_worktree.sh

Prepares a fresh git worktree for development.

**When to run:** in a new worktree, before your first build or test. Cursor runs it automatically through `.cursor/worktrees.json`. Codex runs it through `.codex/environments/environment.toml`. Claude Code copies `example/android/local.properties` via `.worktreeinclude` but does not run setup commands, so run it by hand there.

**What it does:**

- Copies `example/android/local.properties` from the main checkout when it is missing here (source resolved from `$ROOT_WORKTREE_PATH`, else the first entry of `git worktree list`). Skips quietly if the source file is absent — Flutter can regenerate it.
- Runs `fvm flutter pub get` at the package root, then again in `example/` (a separate package, not a pub workspace)
- Prints the next steps: package tests at the root, `flutter run` in `example/`

It does not install CocoaPods. Example iOS and macOS use Swift Package Manager; the first `flutter run` in `example/` generates the ephemeral Swift package. It is safe to re-run: existing files are left untouched.

```bash
bash scripts/setup_worktree.sh
```

See [docs/guides/using-worktrees-guidance.md](../docs/guides/using-worktrees-guidance.md).

---
