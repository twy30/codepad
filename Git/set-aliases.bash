git config --global myVersion.alias '2021-Aug-09 11:28:26'

git config --global --remove-section alias

git config --global alias.alias '!git config --get-regexp ^myVersion\. | sort; git config --get-regexp ^alias\.'

git config --global alias.aa 'add --all'
git config --global alias.bavv 'branch --all --verbose --verbose'
git config --global alias.c commit
git config --global alias.cddr 'clean -d --dry-run'
git config --global alias.cddrX 'clean -d --dry-run -X'
git config --global alias.co checkout
git config --global alias.ms 'merge --squash'
git config --global alias.rup 'remote update --prune'
git config --global alias.rv 'remote --verbose'
git config --global alias.s 'status'
git config --global alias.w '!myGitAliasW() { git add --all && git commit -m "${1:-Add & Commit All}"; }; myGitAliasW'