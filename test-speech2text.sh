#!/usr/bin/env bash

# 실행방법
#
# ./test-speech2text.sh en-us 
# ./test-speech2text.sh ko-kr
#
# en-us 옵션은 default. 없어도 됨
#
if [ -z "$1" ]
then
  lang="en-us"
else
  lang="$1"
fi

echo "Recording... Press Ctrl+C to Stop."

# linux인 경우 
# arecord -D "plughw:1,0" -q -f cd -t wav | ffmpeg -loglevel panic -y -i - -ar 16000 -acodec flac file.flac  > /dev/null 2>&1

# osx 인 경우
# 샘플링 레이트를 16,000로 바꾼다. 구글 음성인식 API는 16K의 flac 포맷만 가능.
rec -t flac - | sox - out.flac rate 16k 

echo "Processing ${lang}..."

wget -q -U "Mozilla/5.0" --post-file out.flac --header "Content-Type: audio/x-flac; rate=16000" -O - "http://www.google.com/speech-api/v1/recognize?lang=${lang}&client=chromium" | cut -d\" -f12  >stt.txt

echo -n "You Said: "
cat stt.txt

rm out.flac
rm stt.txt


