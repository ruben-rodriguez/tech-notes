#!/bin/bash -xe


#allow passing a commit message
message=$1

# remove public
rm -rf public

#generate static site into public & copy files into dist folder
hugo --minify --gc

cp -R public/* ../tech-notes-site

cd ../tech-notes-site

if [ "$message" == "" ]; then
  #use last git commit message for deploying into github pages
  message=`git log -1 --pretty=%B`
fi

git add . && git commit -m "$message" && git push origin master #replace "master" with "gh-pages" if you are deploying into a project site