#!/bin/bash
all2dos() { find * -exec dos2unix {} \; }
export -f all2dos
git filter-branch -f --tree-filter 'all2dos' --tag-name-filter cat --prune-empty -- --all
