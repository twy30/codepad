git config --global --remove-section alias

git config --global alias.aa 'add --all'
git config --global alias.alias "config --get-regexp '^alias\.'"
git config --global alias.bavv 'branch --all --verbose --verbose'
git config --global alias.c commit
git config --global alias.cddr 'clean -d --dry-run'
git config --global alias.cddrX 'clean -d --dry-run -X'
git config --global alias.co checkout
git config --global alias.dt 'difftool --diff-filter=d'
git config --global alias.ms 'merge --squash'
git config --global alias.rup 'remote update --prune'
git config --global alias.rv 'remote --verbose'
git config --global alias.s status
git config --global alias.w '!myGitAliasW() { git add --all && git commit -m "${1:-Add & Commit All}"; }; myGitAliasW'
git config --global alias.z '-c core.quotepath=false status'
