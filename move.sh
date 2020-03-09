#!/bin/bash

filename=$1
IFS=$'\n\n'

for line in `cat $filename`
do
  # echo $line
  OLD_IFS="$IFS"
  IFS=";"
  array=($line)
  IFS="$OLD_IFS"

  old_origin=${array[0]}
  new_origin=${array[1]}
  echo "old origin: ${old_origin}"
  echo "new origin: ${new_origin}"
  mkdir workdir
  sup_path=`pwd`
  cd workdir
  path=`pwd`
  echo "开始clone项目..."
  git clone --mirror $old_origin
  echo "clone项目完毕."

  for dir in `ls .`
  do
  if [ -d $dir ]
  then
  echo "项目目录: $dir"
  cd $dir
  echo "修改项目origin url..."
  git remote set-url origin $new_origin
  echo "开始推送新仓库..."
  git push -f origin
  echo "推送完毕."
  fi
  done
  rm -rf $path
  cd $sup_path
  echo "done"
done