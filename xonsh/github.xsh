def _mark_gh_notifications_read():
    # grabs threads that start with `chore(deps` or `chore(conda`
    threads = $(gh api --paginate notifications --jq r'.[] | "\(.id) \(.subject.title)"' | grep -E r"chore\(deps|chore\(conda" | cut -d " " -f1).strip().split()
    # marks them read
    print(f"Marking {len(threads)} threads as read...")
    for thread in _tqdm(threads):
        gh api --method PATCH -H "Accept: application/vnd.github.v3+json" /notifications/threads/@(thread)
    
aliases["mark_gh_read"] = _mark_gh_notifications_read

def _mark_merged_prs():
    _capture = $(gh api --paginate notifications --jq r'.[] | select(.subject.type=="PullRequest") | "\(.id) \(.subject.url)"').strip().split()
    ids = _capture[::2]
    prs = _capture[1::2]
    merged = []
    print(f"Grabbing status of {len(prs)} PRs...")
    for id, pr in _tqdm(zip(ids, prs)):
        if !(gh api -H "Accept: application/vnd.github+json" @(f"{pr.strip('https://api.github.com')}/merge")):
            merged.append(id)
    print(f"\nMarking {len(merged)} PRs as read...")
    for thread in _tqdm(merged):
        gh api --method PATCH -H "Accept: application/vnd.github.v3+json" /notifications/threads/@(thread)

aliases["mark_merged_prs_read"] = _mark_merged_prs

# grabs PRs where the user that opened it is a Bot
# gh api --paginate notifications --jq r'.[] | select(.subject.title | contains("deps")) | .subject.url' | cut -d "/" -f4- | xargs gh api --jq r'select(.user.type == "Bot") | .id'

