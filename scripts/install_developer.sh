#!/bin/bash
git config --global user.name "Kai Davenport"
git config --global user.email "kaiyadavenport@gmail.com"
git config --global credential.helper 'cache --timeout=3600'
git config --global push.default simple
git config --global alias.add-commit '!git add -A && git commit'