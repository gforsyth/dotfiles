import queue
from concurrent.futures import ThreadPoolExecutor, as_completed


def _mark_gh_notifications_read():
    # grabs threads that start with `chore(deps` or `chore(conda`
    threads = $(gh api --paginate notifications --jq r'.[] | "\(.id) \(.subject.title)"' | grep -E r"chore\(deps|chore\(conda" | cut -d " " -f1).strip().split()

    def _mark_read(thread):
        gh api --method PATCH -H "Accept: application/vnd.github.v3+json" /notifications/threads/@(thread)
    
    with ThreadPoolExecutor() as executor:
        futures = {executor.submit(_mark_read, thread): thread for thread in threads}
    for future in _tqdm(as_completed(futures)):
        pass
        

def _mark_merged_prs():
    merged = queue.Queue()
    _capture = $(gh api --paginate notifications --jq r'.[] | select(.subject.type=="PullRequest") | "\(.id) \(.subject.url)"').strip().split()
    ids = _capture[::2]
    prs = _capture[1::2]


    def _get_pr_status(id, pr):
        if !(gh api -H "Accept: application/vnd.github+json" @(f"{pr.strip('https://api.github.com')}/merge")):
            merged.put(id)

    print(f"Grabbing status of {len(prs)} PRs...")

    with ThreadPoolExecutor() as executor:
        futures = {executor.submit(_get_pr_status, id, pr):id for id, pr in zip(ids, prs)}

    for future in as_completed(futures):
        pass

    print(f"~{merged.qsize()} PRs to mark read")

    # sentinel value to mark queue exhaustion
    merged.put(None)

    def _mark_read(thread):
        gh api --method PATCH -H "Accept: application/vnd.github.v3+json" /notifications/threads/@(thread)

    futures = dict()

    with ThreadPoolExecutor() as executor:
        while (thread := merged.get()) is not None:
            futures[executor.submit(_mark_read, thread)] = thread

    for future in as_completed(futures):
        pass

# grabs PRs where the user that opened it is a Bot
# gh api --paginate notifications --jq r'.[] | select(.subject.title | contains("deps")) | .subject.url' | cut -d "/" -f4- | xargs gh api --jq r'select(.user.type == "Bot") | .id'

_mark_gh_read = lambda: _mark_merged_prs() and _mark_gh_notifications_read()

aliases["mark_gh_read"] = _mark_gh_read
