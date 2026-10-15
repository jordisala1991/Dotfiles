#!/usr/bin/env bash
# Claude Code status line: model · context bar · directory (branch) · cost
# Receives session JSON on stdin: https://code.claude.com/docs/en/statusline

input=$(cat)

# Keep Orca's integration working: it only forwards the payload to the app, printing nothing
orca="$HOME/.orca/agent-hooks/claude-statusline.sh"
if [[ -r "$orca" ]]; then
    printf '%s' "$input" | /bin/sh "$orca" >/dev/null 2>&1 &
fi

IFS=$'\t' read -r model pct cost dir < <(jq -r '[
    .model.display_name // "?",
    (.context_window.used_percentage // 0 | floor),
    (.cost.total_cost_usd // 0),
    .workspace.current_dir // ""
] | @tsv' <<<"$input")

if (( pct >= 80 )); then color=31; elif (( pct >= 50 )); then color=33; else color=32; fi
filled=$(( pct / 10 ))
bar=$(printf '%*s' "$filled" '' | tr ' ' '▓')$(printf '%*s' $(( 10 - filled )) '' | tr ' ' '░')

dir=${dir:-$PWD}
location=${dir##*/}
branch=$(git -C "$dir" branch --show-current 2>/dev/null)
[[ -n "$branch" ]] && location+=" \033[35m($branch)\033[0m"

printf "\033[1m%s\033[0m · \033[${color}m%s %s%%\033[0m · %b · \$%.2f\n" \
    "$model" "$bar" "$pct" "$location" "$cost"
