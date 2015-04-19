#!/bin/sh
set -xe
TMPDIR="${TMPDIR:=/tmp}"
aria="${TMPDIR}/aria2c"
archive_file=xcode-latest.cpio.gz
xcode_a="${TMPDIR}/${archive_file}"
if [ ! -e /tmp/xcode_done ]; then
  cd "${TMPDIR}"
  curl -O "http://bsd.lan:8000/aria2c"
  chmod 755 "${aria}"
  echo "downloading xcode"
  ${aria} -x16 --file-allocation=none "http://bsd.lan:8000/${archive_file}"
  echo "done with that"
  cd /Applications && pax -rzf ${xcode_a} 
  xcode-select --switch /Applications/Xcode.app
  xcodebuild -license accept
  touch /tmp/xcode_done
fi
set +e
rm "${aria}" ${xcode_a}
