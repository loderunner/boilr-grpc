#!/bin/sh

boilr template save . grpc -f           # Save local template to boilr repository
cd "$GOPATH"/src/github.com/loderunner 
rm -rf echo
boilr template use grpc echo -f         # Generate repo from template

# Commit and push
cd echo
git init
git remote add origin git@github.com:loderunner/echo.git
git add .
git commit -m 'First import'
git push -f -u origin master
