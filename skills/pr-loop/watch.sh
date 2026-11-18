#!/bin/bash
# Prints one line per PR that needs my review: a review request, a head that moved since my last review, or a
# dismissed review. Run it from the repo's checkout. State lives in $TMPDIR so a re-armed watch stays quiet, and
# --fresh clears it so the first poll lists everything already waiting.
set -o pipefail
export LC_ALL=C
me=$(gh api user --jq .login) || exit 1
read -r owner name < <(gh repo view --json owner,name --jq '"\(.owner.login) \(.name)"') || exit 1
state="${TMPDIR:-/tmp}/pr-loop-$owner-$name.state"
[ "$1" = --fresh ] && rm -f "$state"
touch "$state"
failing=

poll() {
  {
    gh pr list --search "review-requested:@me draft:false" \
      --json number,headRefOid --jq '.[] | "review-requested #\(.number) \(.headRefOid)"' &&
    gh api graphql -f owner="$owner" -f name="$name" -f me="$me" -f query='
      query($owner: String!, $name: String!, $me: String!) { repository(owner: $owner, name: $name) {
        pullRequests(states: OPEN, first: 100, orderBy: {field: UPDATED_AT, direction: DESC}) {
          nodes { number isDraft headRefOid reviews(last: 1, author: $me) { nodes { state commit { oid } } } } } } }' \
      --jq '.data.repository.pullRequests.nodes[] | select(.isDraft | not) | . as $pr | .reviews.nodes[]
        | if .state == "DISMISSED" then "review-dismissed #\($pr.number) \($pr.headRefOid)"
          elif .state != "APPROVED" and .commit.oid != $pr.headRefOid then "moved-since-my-review #\($pr.number) \($pr.headRefOid)"
          else empty end'
  } | sort
}

while true; do
  if cur=$(poll 2>"$state.err"); then
    failing=
    printf '%s' "$cur${cur:+$'\n'}" > "$state.new"
    comm -13 "$state" "$state.new"
    mv "$state.new" "$state"
  elif [ -z "$failing" ]; then
    failing=1
    echo "poll failed: $(head -c 500 "$state.err" | tr '\n' ' ')"
  fi
  sleep 60
done
