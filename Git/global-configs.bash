git config --global --remove-section alias

git config --global alias.aa 'add --all'
git config --global alias.alias "config --get-regexp '^alias\.'"
git config --global alias.bavv 'branch --all --verbose --verbose'
git config --global alias.bp1 '!myGitAlias_bp1() { git lib-PrependToNonMainBranch __1-ReadyForMain- "$1"; }; myGitAlias_bp1'
git config --global alias.bp2 '!myGitAlias_bp2() { git lib-PrependToNonMainBranch __2-MergedToMain- "$1"; }; myGitAlias_bp2'
git config --global alias.c commit
git config --global alias.cddr 'clean -d --dry-run'
git config --global alias.cddrX 'clean -d --dry-run -X'
git config --global alias.co checkout
git config --global alias.cob 'checkout -b'
git config --global alias.com 'checkout main'
git config --global alias.dt 'difftool --diff-filter=ad'
git config --global alias.dtc 'difftool --cached --diff-filter=ad'
git config --global alias.id '!myGitAlias_id() { cd "$GIT_PREFIX"; git ls-tree --full-name --long HEAD "$1"; git log --format=%cI_%H --max-count=1 -- "$1"; }; myGitAlias_id'
git config --global alias.lib-PrependToNonMainBranch '!myGitAlias_lib_PrependToNonMainBranch() { local myBranchName=${2:-`git rev-parse --abbrev-ref=strict HEAD`}; readonly myBranchName; if [ "$myBranchName" != main ]; then git branch --move "$myBranchName" "$1$myBranchName"; fi; }; myGitAlias_lib_PrependToNonMainBranch'
git config --global alias.ms 'merge --squash'
git config --global alias.rup 'remote update --prune'
git config --global alias.rv 'remote --verbose'
git config --global alias.s status
git config --global alias.w '!myGitAlias_w() { git add --all && git commit --allow-empty-message --message="$1"; }; myGitAlias_w'

git config --global core.editor 'code --wait'
git config --global core.quotePath false
git config --global diff.tool vscode
git config --global difftool.prompt false
git config --global difftool.vscode.cmd 'code --wait --diff "$LOCAL" "$REMOTE"'
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait "$MERGED"'
