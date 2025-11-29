#!/usr/bin/env bash
set -u

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 SUBDIR" >&2
  exit 1
fi

dir="$1"
if [[ ! -d "$dir" ]]; then
  echo "Not a directory: $dir" >&2
  exit 2
fi

while IFS= read -r -d '' file; do
  filename="${file##*/}"

  # hidden file with no other dot -> no extension
  if [[ "$filename" == .* && "${filename#*.}" != *.* && "${filename#*.}" != "" ]]; then
    ext="NO_EXT"; base="$filename"
  elif [[ "$filename" == *.* ]]; then
    ext="${filename##*.}"; base="${filename%.*}"
  else
    ext="NO_EXT"; base="$filename"
  fi

  ext_up=${ext^^}
  destdir="$dir/$ext_up"
  mkdir -p -- "$destdir"

  # compute a unique target name before moving
  if [[ "$ext" == "NO_EXT" ]]; then
    candidate="$base"
  else
    candidate="$base.$ext"
  fi

  n=1
  while [[ -e "$destdir/$candidate" ]]; do
    if [[ "$ext" == "NO_EXT" ]]; then
      candidate="${base}_$n"
    else
      candidate="${base}_$n.$ext"
    fi
    n=$((n + 1))
  done

  mv -- "$file" "$destdir/$candidate"
done < <(find "$dir" -maxdepth 1 -type f -print0)
