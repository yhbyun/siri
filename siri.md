
# 시리 흉내내기 

변용훈
[@river](http://twitter.com/river)

---

[Raspberry Pi Voice Recognition Works Like
Siri](http://blog.oscarliang.net/raspberry-pi-voice-recognition-works-like-siri/) 스크립트를 OSX 용으로 수정 

<iframe width="420" height="315" src="//www.youtube.com/embed/OP2IvkqrRnU"
frameborder="0" allowfullscreen></iframe>

---

# 데모

---

## 사용 API

- [Google Speech Recognition API](https://gist.github.com/alotaiba/1730160)
  - [Web Speech API Demo](https://www.google.com/intl/en/chrome/demos/speech.html)
- [Wolfram|Alpah API](http://products.wolframalpha.com/api/)
- [Google Text to Speech API](https://gist.github.com/alotaiba/1728771)

---

## 사용 프로그램

#### sox

- 사운드 레코딩 및 flac 변환 담당 
- $ brew install sox --with-flac

#### wolframalpha

- Python 패키지 
- woframalpha API 질의 담당 
- $ pip install wolframalpha

#### mplayer

- mp3 포맷 play 담당 
- $ brew install mplayer

---

## 구조

<img src='/img/siri1.png' style='border:none' />

---

## speech2text.sh 

```
LANGUAGE="en-us"

# 샘플링 레이트를 16,000로 바꾼다. 구글 음성인식 API는 16K의 flac 포맷만 가능.
rec -t flac -q - | sox - out.flac rate 16k 

wget -q -U "Mozilla/5.0" --post-file out.flac --header "Content-Type: audio/x-flac; rate=16000" 
  -O - "http://www.google.com/speech-api/v1/recognize?lang=${LANGUAGE}&client=chromium" 
  | cut -d\" -f12  > stt.txt

rm out.flac
```

---

## queryprocess.py

```
mport wolframalpha
import sys

# Get a free API key here http://products.wolframalpha.com/api/
# This is a fake ID, go and get your own, instructions on my blog.
app_id='R6EJKE-9XLLHX2EA2'

client = wolframalpha.Client(app_id)

query = ' '.join(sys.argv[1:])
res = client.query(query)

if len(res.pods) > 0:
    texts = ""
    pod = res.pods[1]
    if pod.text:
        texts = pod.text
    else:
        texts = "I have no answer for that"
    # to skip ascii character in case of error
    texts = texts.encode('ascii', 'ignore')
    print texts
else:
    print "Sorry, I am not sure."
```

---

## text2speech.sh

```
#!/usr/bin/env bash

INPUT=$*
STRINGNUM=0
ary=($INPUT)
for key in "${!ary[@]}"
do
  SHORTTMP[$STRINGNUM]="${SHORTTMP[$STRINGNUM]} ${ary[$key]}"
  LENGTH=$(echo ${#SHORTTMP[$STRINGNUM]})

  if [[ "$LENGTH" -lt "100" ]]; then
    SHORT[$STRINGNUM]=${SHORTTMP[$STRINGNUM]}
  else
    STRINGNUM=$(($STRINGNUM+1))
    SHORTTMP[$STRINGNUM]="${ary[$key]}"
    SHORT[$STRINGNUM]="${ary[$key]}"
  fi
done
for key in "${!SHORT[@]}"
do
  say() { local IFS=+;mplayer -really-quiet -noconsolecontrols 
    "http://translate.google.com/translate_tts?tl=en&q=${SHORT[$key]}"; }
  say $*
done
```

---

## main.sh

```
#!/usr/bin/env bash

while :
do
  echo "Recording... Press Ctrl+C to Stop."

  ./speech2text.sh

  QUESTION=$(cat stt.txt)
  echo "Me: " $QUESTION
  rm stt.txt

  ANSWER=$(python queryprocess.py $QUESTION)
  echo "Robot: " $ANSWER

  ./text2speech.sh $ANSWER
done
```

---

## TODO 

- silence detection
http://unix.stackexchange.com/questions/55032/end-sox-recording-once-silence-is-detected


---

![](http://media-cache-cd0.pinimg.com/736x/21/84/f9/2184f9764bd1e30fb624ec1c6547c727.jpg)
  
