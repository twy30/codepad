git config --global core.editor 'code --wait'
git config --global diff.tool vscode
git config --global difftool.prompt false
git config --global difftool.vscode.cmd 'code --wait --diff $LOCAL $REMOTE'
git config --global merge.tool vscode
git config --global mergetool.vscode.cmd 'code --wait $MERGED'
