# Using git worktrees

Status: current guidance. How to run several checkouts of this repo in parallel with Claude Code, Codex, Cursor and Fork, and what this repo ships to make a new worktree usable.

This is a published Flutter **package** (`lib/`, `test/`) plus a demo app in `example/`. A new worktree needs package deps, example-app deps, and at most one gitignored Android file — not flavor secrets or generated Dart.

## Worktrees: The refresher

A worktree is a second (third, fourth…) checkout of the same repo in its own folder. Each worktree has its own copy of every file, but they all share the same `.git` metadata about commits and branches. So: separate files on disk, one shared history.

```bash
git worktree add ../fcp-feature -b feature/x   # new branch
git worktree add ../fcp-hotfix hotfix/y        # existing branch
git worktree list
git worktree remove ../fcp-feature
```

Three consequences worth internalising up front:

1. **A branch can only be checked out in one worktree at a time.** Git enforces one-branch-per-worktree because a branch ref is a single mutable pointer, and letting two working copies advance it would create race conditions. You'll hit `fatal: 'feature/a' is already used by worktree at ...` eventually. It's not a bug.
2. **Only tracked files come along.** No `.dart_tool/`, no `build/`, and no `example/android/local.properties`. Every tool below has a mechanism to paper over this — use it.
3. **Commits, branches, stashes, and remotes are shared instantly.** Commit in a worktree, and Fork's main tab sees it immediately. No pushing between worktrees.

---

Below we explain using worktrees in the following tools:
- Claude Code Desktop
- Codex desktop app
- Cursor
- Fork

## Claude Code Desktop

This is the least work of the four: in the desktop app, every new session gets its own worktree automatically. Click New Session, the app does the `git worktree add`. They land in `.claude/worktrees/` by default, and you can change the location and the branch prefix in Desktop settings. When you're done, the archive icon removes the worktree and its branch.

`.claude/worktrees/` is already in this repo's `.gitignore`, so they do not show up as untracked noise.

From the CLI it's opt-in:

```bash
claude --worktree color-picker      # or -w
claude --worktree "#1234"           # worktree from a PR, for review
```

The worktree lands under `.claude/worktrees/<name>/` on a branch named `worktree-<name>`. Quote the `#` or your shell eats it as a comment.

This repo ships a `.worktreeinclude` at the root, so gitignored files that a worktree actually needs come across automatically. It uses `.gitignore` syntax, and only files that match *and* are already gitignored get copied, so tracked files are never duplicated. This applies to `--worktree`, subagent worktrees, and desktop parallel sessions alike. It currently covers `example/android/local.properties` — Flutter can regenerate that file if it is missing. Claude Code does **not** run setup commands; in a new worktree run `bash scripts/setup_worktree.sh` (or tell the agent to — `AGENTS.md` says the same).

Two more things worth knowing:

- New worktrees branch from the repo's default branch (`master`) by default. This repo commits `.claude/settings.json` with `worktree.baseRef` set to `"head"`, so a new worktree follows **whatever branch you currently have checked out** — a feature branch or `master`. Do not change that back to `"fresh"` if you want the worktree to carry unpushed commits and in-progress work.
- While a session is isolated in a worktree, Claude Code actively blocks edits, command working directories, and git redirects that target the main checkout. So a runaway agent can't stomp your main tree.

---

## Codex desktop app

Codex makes it an explicit choice per chat. In the new chat view you pick **Worktree** under the composer, choose the branch to base it on, and submit — Codex creates the worktree from that branch's HEAD. By default it works in detached HEAD.

The detached-HEAD default is deliberate: it lets Codex spin up many worktrees without polluting your branch list. When you want to keep the work, hit **Create branch here** in the chat header, then commit, push, and open a PR from that checkout.

The distinctive Codex feature is **Handoff**: select Hand off in the chat header to move a chat between the worktree and Local — Codex handles the git operations to move chat *and* code safely, and each chat keeps its associated worktree so handing it back returns it to the same environment. Think of Local as foreground, Worktree as background.

Housekeeping: worktrees live in `$CODEX_HOME/worktrees`, changeable under Settings > Worktrees > Worktree root. Codex keeps your 15 most recent managed worktrees by default and snapshots the work before deleting one, so you can restore if you reopen the chat. For a long-lived environment, create a permanent worktree from the three-dot menu on a project in the sidebar — those aren't auto-deleted and can host multiple chats. Codex reads `.worktreeinclude` too.

This repo commits `.codex/environments/environment.toml` so a Codex-managed worktree runs `bash scripts/setup_worktree.sh` automatically. Pick the same branch you currently have checked out (feature branch or `master`), not an unrelated remote default, unless you want a clean tree.

---

## Cursor — and "how do I switch and see status" question

Here's the honest answer: **Cursor's worktree UI lives in the Agents Window, not the classic IDE.** The UI-native worktrees feature is only available in the Agents Window; in the IDE you use the worktree slash commands. Get there with `Cmd+Shift+P → Open Agents Window` (and `Open IDE` to go back — you can have both open).

In the Agents Window, starting or moving an agent into a worktree creates a separate checkout for it, and after it finishes you review the result there, then either keep working in the worktree, commit/PR from it, or bring it back to your main workspace. That window is your switcher and status board.

In the classic IDE:

```
/worktree fix the failing ColorPicker tests
/apply-worktree      # pull the changes into your main checkout to test
/delete-worktree     # clean up
/best-of-n sonnet,gpt,composer fix the flaky ColorPicker test
```

`/best-of-n` runs the same task across several models, each in its own worktree, then you pick a winner — it compares only, it won't merge for you.

**To actually view multiple worktrees side by side in the IDE:** open each worktree folder as its own Cursor window. A worktree is just a folder with a `.git` *file* pointing back at the main repo, so the built-in git UI resolves it correctly — right branch, right diffs, right blame. There's no worktree dropdown in the IDE the way GitHub Desktop has one. A multi-root workspace with each worktree as a folder also works if you want one window, at the cost of a shared search scope.

Per-worktree setup is already committed as `.cursor/worktrees.json`, which runs the repo's setup script:

```json
{
  "setup-worktree-unix": [
    "bash scripts/setup_worktree.sh"
  ]
}
```

Cursor checks this file when creating a worktree from the Agents Window, the IDE, or the CLI, and exports `$ROOT_WORKTREE_PATH` while it runs — the script uses it to find your main checkout. Keeping the steps in a committed script rather than an inline command array means Claude Code and Codex users can run exactly the same setup. Cursor explicitly recommends against symlinking dependencies into worktrees, so the script installs into each checkout instead. If setup appears not to run, open the Output panel and select "Worktrees Setup".

Watch the cleanup setting: Cursor keeps a machine-wide maximum of 25 worktrees by default (`cursor.worktreeMaxCount`) across every workspace, and worktrees created outside the manager — including via `git worktree add` — are eligible for deletion. If you hand-roll worktrees for long-lived work, raise that number or park them outside Cursor's root.

---

## Fork - MacOS Git client

Fork has had worktrees in the sidebar since 2.31 and create/delete since 2.41, but the useful stuff is recent:

| Version        | What landed                                                                                                                                            |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 2.59           | Worktree icon on branches checked out in other worktrees                                                                                               |
| 2.62 (Jan '26) | "Copy Path" on worktree context menu                                                                                                                   |
| 2.63 (Feb '26) | **Create Worktree dialog**, also via Quick Launch (⌘P); option to remove the worktree when deleting a branch; parent repo name in worktree tab headers |
| 2.65 (Mar '26) | Disambiguate worktree tabs/sidebar items with the same folder name; better submodule handling in worktrees                                             |
| 2.68 (Jun '26) | **Checkout remote branch as worktree**                                                                                                                 |
| 2.69 (Jul '26) | Current release                                                                                                                                        |

Workflow: worktrees appear in a **Worktrees** section in the left sidebar (above pinned items). Right-click → open in a tab. Each worktree gets its own tab with its own Local Changes view, so you get exactly what you asked for — parallel status across all your in-flight work in one app. ⌘P then "Create Worktree" is the fastest path.

If you're on anything older than 2.63, upgrade before you start; the pre-2.63 flow required creating the branch first and was genuinely annoying.

---

## Committing, merging, and PRs

Nothing special. A worktree is a normal checkout, so:

```bash
cd .claude/worktrees/color-picker
git add -A && git commit -m "..."
git push -u origin worktree-color-picker
gh pr create --fill
```

Or just tell the agent: "commit and push these changes, then open a PR" — Cursor's docs call this out explicitly, and it's the normal path in all four tools. From Codex you'd hit **Create branch here** first, since the worktree starts detached.

The four things that actually differ:

**One branch, one place.** If you want to check out the worktree's branch in your main tree afterwards, you must first move the worktree off it (or remove the worktree). In Codex, use Handoff to move the chat into Local rather than trying to keep the same branch checked out in both spots.

**Merge into `master` from wherever `master` is checked out** — usually your main worktree. Or don't merge locally at all: merge the PR on GitHub, then `git fetch && git pull` in that checkout.

**Clean up in the right order.** `git worktree remove <path>` (add `--force` if there are uncommitted changes or untracked files), *then* delete the branch. Fork's 2.63 "remove corresponding worktree when deleting a branch" option does both. Claude Code's desktop archive icon does both. Codex auto-prunes.

**Rebasing across worktrees is fine.** Shared `.git` means `git rebase origin/master` inside a worktree works normally, and conflict resolution is local to that folder.

One nice trick: reviewing a colleague's PR without touching your own work. `claude --worktree "#1234"` fetches the PR head and creates a worktree at `.claude/worktrees/pr-1234`. Or in Fork 2.68+, checkout the remote branch directly as a worktree.

---

## Cloud / background / phone

This splits into two genuinely different things, and conflating them is the main source of confusion.

### Cloud sessions — code runs on someone else's VM

**Claude Code on the web.** Go to claude.ai/code, authorize the Claude GitHub App (or run `/web-setup` in your terminal to sync your existing `gh` token). Sessions persist even if you close the browser, and you can monitor them from the Claude mobile app. Each session gets an isolated VM that clones the repo, works on its own branch, and pushes.

From the terminal:

```bash
claude --cloud "Fix the flaky test in color_picker_test.dart"
claude --cloud "Update the API docs"      # these run simultaneously
/tasks                                     # check on all of them
claude --teleport                          # pull one back into your terminal
```

The cloud VM clones your GitHub remote at your current branch, not your local checkout — so push first if you have local commits. Teleport requires a clean working directory, the same repo (not a fork), the branch pushed, and the same claude.ai account.

**Package tests can run in a cloud VM** (`fvm flutter test` / `flutter test`). Running the `example/` app on a simulator still needs the Mac.

A pattern worth stealing: plan locally in plan mode, commit the plan to the repo, then `claude --cloud "Execute the plan in docs/plan.md"` for autonomous execution.

There's also **auto-fix**: Claude subscribes to GitHub activity on a PR and investigates CI failures and review comments, pushing a fix when one is clear. Turn it on from the CI status bar in a web session, with `/autofix-pr` from your terminal while on the PR branch, or from the mobile app by telling Claude to watch the PR. Requires the GitHub App installed. Note it can't react to merge conflicts from the base branch advancing — GitHub doesn't emit a webhook for that.

Two caveats: `--cloud` handles one repository at a time, and cloud sessions share your account's normal rate limits — running things in parallel burns them proportionately, though there's no separate compute charge. Research preview for Pro/Max/Team.

**Cursor cloud agents + iOS.** Cursor for iOS is a native app for controlling agents running in the cloud and on your computer — start agents, watch live, review and merge PRs from your phone. Same backend as cursor.com/agents and the desktop Agents Window. iPhone iOS 26+ / iPad iPadOS 26+, English only, Android planned, and it's in beta. You can start a task, lock the phone, and come back — agents keep running in the cloud regardless of your connection, and you get a push when an agent finishes a turn, with up to eight tracked via Live Activities and the Dynamic Island.

Editor, terminal, secrets, environment config, MCP management, and source-control setup stay on the web — mobile shows changed files in a diff view, not a full workspace. Cloud Agents also require cloud data storage, so if you're on legacy Privacy Mode you'll have to switch (one-way) before you can start agents on mobile.

### Remote control — code runs on *your* Mac, phone is a window

This is what you want when the task needs the example app on a simulator or local MCP servers. Package-only work (API, tests, docs) is fine in a cloud VM.

**Claude Code Remote Control.** Run `claude remote-control`, `claude --remote-control`, or `/remote-control` inside an existing session. Claude keeps running locally the whole time, so code execution and filesystem access stay on your machine — your MCP servers, project config, and `@` file autocomplete all still work. Then open claude.ai/code or tap **Code** in the Claude mobile app's navigation; Remote Control sessions show a computer icon with a green dot when online. To turn it on for every interactive session, run `/config` and set "Enable Remote Control for all sessions" to true. For push notifications, use the same account on the phone app and enable "Push when Claude decides" in `/config`.

Available on Pro/Max/Team/Enterprise; API keys aren't supported, and one remote session per interactive process outside server mode.

Practical workflow: kick off a big refactor in a worktree before you leave the desk, get a push when it needs an approval, tap yes from the tram.

**Cursor Remote Control** is the same idea from the other side: the agent loop moves to Cursor's cloud while every tool call — terminal commands, file edits, tests, git — runs on your computer. Requires Cursor 3.9.8+, enabled under Settings > Agents in the Agents Window, a git-backed workspace, and your computer awake and online. Run `/remote-control` in the agent input, then pick it up in the iOS app inbox.

**Codex on mobile** is worth flagging: worktrees don't run locally on your phone. With Remote, the mobile app controls Codex on your connected computer, where the repo and worktree live. So it's the remote-control model, not a cloud model.

---

## Flutter-specific gotchas

These will bite you in the first hour if you don't front-load them:

- **Run `scripts/setup_worktree.sh` first** if the tool did not already. It copies `example/android/local.properties` when that file exists in the main checkout, then runs `fvm flutter pub get` at the package root and again in `example/` (a separate package, not a pub workspace). Cursor runs it via `.cursor/worktrees.json`; Codex runs it via `.codex/environments/environment.toml`; Claude Code copies `local.properties` through `.worktreeinclude` but does not run setup commands, so run the script by hand (or tell the agent to).
- **This package has no generated Dart.** There is no build_runner, Freezed, or Drift. `.dart_tool/` and `build/` are gitignored and are recreated by `pub get` / `flutter test` / `flutter run`.
- **Example iOS and macOS use Swift Package Manager**, not CocoaPods. Do not run `pod install`. The first `flutter run` in `example/` generates the ephemeral Swift package. `example/lib/demo/pods/` is Riverpod state, not CocoaPods.
- **Simulator collisions** apply only if you run the example app. Two `flutter run` instances fight over the same simulator and DevTools ports, and worktrees do not isolate simulators. Keep to one `flutter run` per simulator across all your worktrees. Package tests need no simulator: `fvm flutter test` from the repo root is enough.
- **Disk.** Multiple Flutter worktrees with example build output still add up. Both Cursor and Codex auto-prune; Claude Code's `--worktree` worktrees are never swept automatically, so clean those up yourself. This tree is small compared with a production app — 2–3 concurrent worktrees is still a sensible cap until you know your disk budget.

---

## Branching: worktrees follow HEAD

PRs land on `master`. Feature work branches from `master` (or from the feature branch you already have checked out) and opens a PR back into `master`.

This repo sets `worktree.baseRef` to `"head"` in `.claude/settings.json` so a new Claude worktree follows **whatever is currently checked out**, including unpushed commits. That is useful on a feature branch and harmless on `master`.

Consequences for worktrees:

- Base a new worktree on the branch you are actually working on (`master` or a feature branch). Claude Code does this via `worktree.baseRef: "head"`; Codex asks which branch to use — pick the same one.
- Open the PR from the worktree into `master`. Merge on GitHub, or merge locally from whichever checkout has `master`.

## What this repo already ships

You do not need to set any of this up — it is committed:

- `.gitignore` ignores `.claude/worktrees/`.
- `.worktreeinclude` copies `example/android/local.properties` into Claude Code and Codex worktrees.
- `.claude/settings.json` sets `worktree.baseRef` to `"head"` so worktrees follow the current checkout.
- `.cursor/worktrees.json` runs `scripts/setup_worktree.sh` for Cursor worktrees.
- `.codex/environments/environment.toml` runs `scripts/setup_worktree.sh` for Codex-managed worktrees.
- `scripts/setup_worktree.sh` copies `example/android/local.properties` when present, then runs `fvm flutter pub get` at the root and in `example/`. Cursor and Codex run it automatically; in Claude Code run it by hand:

```bash
bash scripts/setup_worktree.sh
```

So the remaining advice is short: update Fork to 2.63+ so ⌘P → Create Worktree works, try one worktree on something low-stakes and confirm `fvm flutter test` passes, *then* go parallel — and cap yourself at 2–3 concurrent worktrees until you know your disk and build-time budget.

One judgment call worth making early: the bottleneck in parallel agent work is almost never the agents, it's your review bandwidth. Three worktrees producing three PRs you can't review carefully is worse than one you can. Start with genuinely independent tasks — the package API in `lib/`, the tests in `test/`, and the playground in `example/` are a decent natural split, since they rarely touch the same files.
