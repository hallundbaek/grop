#!/bin/sh

function mdtopdf() {
  document=$1
  filename="${document%%.*}"
  docx=$filename.docx
  template=$HOME/.config/grop/template.docx

  if test -f "$template"; then
    pandoc -s $document -o $docx --reference-doc=$template 
  else
    pandoc -s $document -o $docx
  fi
  unoconv -f pdf $docx
}

mdtopdf $1

document=$1
filename="${document%%.*}"

evince $filename.pdf &&

while inotifywait -e close_write $1; do 
  mdtopdf $1
done
