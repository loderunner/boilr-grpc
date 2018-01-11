#!/bin/sh

boilr template save . grpc -f           # Save local template to boilr repository
cd "$GOPATH"/src/github.com/loderunner 
rm -rf echo
boilr template use grpc echo -f         # Generate repo from template
cd echo

# Write README.md
cat > README.md <<EOF
# \`echo\`

Template for a gRPC/REST Go project. Generated with [boilr-grpc](https://github.com/loderunner/boilr-grpc).
EOF

# Commit and push
git init
git remote add origin git@github.com:loderunner/echo.git
git add .
git commit -m 'First import'
git push -f -u origin master
