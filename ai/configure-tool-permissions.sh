#!/bin/sh

export ZSH=$HOME/dotfiles

# Source helper functions
. $ZSH/ai/helpers/output.sh
. $ZSH/ai/helpers/json-settings.sh

info "Configuring MCP permissions…"

SETTINGS_FILE="$HOME/.claude/settings.json"

# Define comprehensive MCP permissions configuration
# Auto-approve safe read-only operations while requiring approval for write/dangerous operations
PERMISSIONS_CONFIG=$(cat <<'EOF'
{
  "permissions": {
    "allow": [
      "mcp__github__get_file_contents",
      "mcp__github__get_issue",
      "mcp__github__get_pull_request",
      "mcp__github__get_pull_request_comments",
      "mcp__github__get_pull_request_files",
      "mcp__github__get_pull_request_reviews",
      "mcp__github__get_pull_request_status",
      "mcp__github__list_commits",
      "mcp__github__list_issues",
      "mcp__github__list_pull_requests",
      "mcp__github__search_code",
      "mcp__github__search_issues",
      "mcp__github__search_repositories",
      "mcp__github__search_users",
      "mcp__memory__read_graph",
      "mcp__memory__search_nodes",
      "mcp__puppeteer__puppeteer_navigate",
      "mcp__puppeteer__puppeteer_screenshot",
      "Bash(pytest:*)",
      "Bash(./bin/fmt:*)",
      "Bash(bin/fmt:*)",
      "Bash(./ai/bin/*:*)",
      "Bash(ai/bin/*:*)",
      "Bash(ls:*)",
      "Bash(find:*)",
      "Bash(grep:*)",
      "Bash(sort:*)",
      "Bash(ruff check:*)",
      "Bash(ruff format:*)",
      "Bash(ruff:*)",
      "Bash(./bin/ruff.sh:*)",
      "Bash(bin/ruff.sh:*)",
      "Bash(git log:*)",
      "Bash(git status:*)",
      "Bash(git diff:*)",
      "Bash(git show:*)",
      "Bash(git branch:*)",
      "Bash(git checkout:*)",
      "Bash(git switch:*)",
      "Bash(git fetch:*)",
      "Bash(git pull:*)",
      "Bash(git merge:*)",
      "Bash(git rebase:*)",
      "Bash(git stash:*)",
      "Bash(git worktree:*)",
      "Bash(git remote:*)",
      "Bash(git tag:*)",
      "Bash(git blame:*)",
      "Bash(git shortlog:*)",
      "Bash(git reflog:*)",
      "Bash(git check-ignore:*)",
      "Bash(git --version:*)",
      "Bash(git add:*)",
      "Bash(git commit:*)",
      "Bash(gh pr list:*)",
      "Bash(gh pr view:*)",
      "Bash(gh pr diff:*)",
      "Bash(gh pr status:*)",
      "Bash(gh pr checks:*)",
      "Bash(gh issue list:*)",
      "Bash(gh issue view:*)",
      "Bash(gh repo view:*)",
      "Bash(gh repo list:*)",
      "Bash(gh repo clone:*)",
      "Bash(gh repo fork:*)",
      "Bash(gh status:*)",
      "Bash(gh auth status:*)",
      "Bash(gh api:*)",
      "Bash(gh search:*)",
      "Bash(gh run list:*)",
      "Bash(gh run view:*)",
      "Bash(gh run watch:*)",
      "Bash(gh workflow list:*)",
      "Bash(gh workflow view:*)",
      "Bash(sed:*)",
      "Bash(awk:*)",
      "Bash(gawk:*)",
      "Bash(cat:*)",
      "Bash(head:*)",
      "Bash(tail:*)",
      "Bash(xargs:*)",
      "Bash(pbcopy:*)",
      "Bash(echo:*)",
      "Bash(xattr:*)",
      "Bash(brew info:*)",
      "Bash([ -f :*)",
      "Bash([ -d :*)",
      "Bash([ -e :*)",
      "Bash(test -f :*)",
      "Bash(test -d :*)",
      "Bash(test -e :*)",
      "Bash(redis-cli:*)",
      "Bash(markdownlint:*)",
      "Bash(curl:*)",
      "Bash(openssl:*)",
      "WebFetch(domain:*)",
      "Fetch(*)",
      "Bash(flox activate -- bash -c :*pytest:*)",
      "Bash(flox activate -- bash -c :*mypy:*)",
      "Bash(flox activate -- bash -c :*bin/fmt:*)",
      "Bash(flox activate -- bash -c :*ruff:*)",
      "Bash(flox activate --:*)",
      "Bash(npm:*)",
      "Bash(npx:*)",
      "Bash(yarn:*)",
      "Bash(pnpm:*)",
      "Bash(next:*)",
      "Bash(next build:*)",
      "Bash(next dev:*)",
      "Bash(next start:*)",
      "Bash(tsc:*)",
      "Bash(node:*)",
      "Bash(elixir:*)",
      "Bash(mix:*)",
      "Bash(mix compile:*)",
      "Bash(mix test:*)",
      "Bash(mix deps.get:*)",
      "Bash(mix deps.update:*)",
      "Bash(mix format:*)",
      "Bash(mix ecto.migrate:*)",
      "Bash(iex:*)"
    ]
  }
}
EOF
)

# Check if all permissions are configured by looking for MCP, git, gh, text processing, and Node/Elixir tools
if command -v jq > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "mcp__github__get_file_contents")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(git log:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(gh pr list:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(ls:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(sed:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(cat:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(sort:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(xargs:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(ruff:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(ruff format:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(git add:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(cargo clippy:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(cargo clippy :* 2>&1::*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(cargo test :* 2>&1::*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Fetch(*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(markdownlint:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(xattr:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(brew info:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash([ -f :*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(git --version:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(git check-ignore:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(ai/bin/*:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(curl:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(openssl:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(npm:*)")' "$SETTINGS_FILE" > /dev/null 2>&1 && \
   jq -e '.permissions.allow[] | select(. == "Bash(mix:*)")' "$SETTINGS_FILE" > /dev/null 2>&1; then
    success "Tool permissions already configured"
else
    # Merge permissions configuration using helper function
    if merge_json_settings "$SETTINGS_FILE" "$PERMISSIONS_CONFIG" "MCP permissions"; then
        success "Safe tool operations auto-approved"
        info "Write/dangerous operations will still require approval:"
        info "  • GitHub: create/update/merge operations"
        info "  • Memory: create/delete operations"
        info "  • Puppeteer: click/fill/evaluate operations"
        info "  • Git: push operations (add/commit/read operations are auto-approved)"
        info "  • GitHub CLI: create/merge operations (read operations are auto-approved)"
    fi
fi