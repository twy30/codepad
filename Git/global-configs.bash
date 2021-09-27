git config --global --remove-section alias

git config --global alias.aa 'add --all'
git config --global alias.alias "config --get-regexp '^alias\.'"
git config --global alias.bavv 'branch --all --verbose --verbose'
git config --global alias.c commit
git config --global alias.cddr 'clean -d --dry-run'
git config --global alias.cddrX 'clean -d --dry-run -X'
git config --global alias.co checkout
git config --global alias.dt 'difftool --diff-filter=ad'
git config --global alias.id '!myGitAliasId() { if [ -f "$1" ]; then git ls-tree --long HEAD "$1"; git log --max-count=1 -- "$1"; fi; }; myGitAliasId'
git config --global alias.ms 'merge --squash'
git config --global alias.rup 'remote update --prune'
git config --global alias.rv 'remote --verbose'
git config --global alias.s status
git config --global alias.w '!myGitAliasW() { git add --all && git commit -m "${1:-Add & Commit All}"; }; myGitAliasW'

git config --global core.editor 'code --wait'
git config --global core.quotePath false
git config --global diff.tool vscode
git config --global difftool.prompt false
git config --global difftool.vscode.cmd 'code --wait --diff "$LOCAL" "$REMOTE"'
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait "$MERGED"'
