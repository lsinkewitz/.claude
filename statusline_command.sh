#!/bin/bash
input=$(cat)

# Model — strip "Claude " prefix for brevity
model=$(echo "$input" | jq -r '.model.display_name // "?"' | sed 's/^Claude //')

# Context usage %
ctx=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)

# Session cost
cost=$(echo "$input" | jq -r '.cost.total_cost_usd // 0' | xargs printf '%.2f')

# Current dir basename
dir=$(echo "$input" | jq -r '.cwd // ""' | xargs basename)

# Git info (only if in a git repo)
cwd=$(echo "$input" | jq -r '.cwd // "."')
git_part=""
if git -C "$cwd" rev-parse --git-dir >/dev/null 2>&1; then
  branch=$(git -C "$cwd" rev-parse --abbrev-ref HEAD 2>/dev/null)
  dirty=""
  git -C "$cwd" diff --quiet HEAD 2>/dev/null || dirty="*"
  git_part=" | 🌿 ${branch}${dirty}"
fi

# Token stats
tok_in=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
tok_out=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
cache_read=$(echo "$input" | jq -r '.context_window.current_usage.cache_read_input_tokens // 0')
cache_create=$(echo "$input" | jq -r '.context_window.current_usage.cache_creation_input_tokens // 0')

# Format token counts (e.g. 12345 -> 12.3k)
fmt_tok() {
  local n=$1
  if [ "$n" -ge 1000000 ] 2>/dev/null; then
    printf '%.1fM' "$(echo "$n / 1000000" | bc -l)"
  elif [ "$n" -ge 1000 ] 2>/dev/null; then
    printf '%.1fk' "$(echo "$n / 1000" | bc -l)"
  else
    echo "$n"
  fi
}

echo "🤖 ${model} | 📊 ${ctx}% | 💲${cost}${git_part} | 📂 ${dir}"
echo "⬇ $(fmt_tok $tok_in) in | ⬆ $(fmt_tok $tok_out) out | 📦 $(fmt_tok $cache_read) cached | ✏ $(fmt_tok $cache_create) new"
