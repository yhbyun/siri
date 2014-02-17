
## 구글 음성인식 API를 이용한 OSX 시리 

[Raspberry Pi Voice Recognition Works Like
Siri](http://blog.oscarliang.net/raspberry-pi-voice-recognition-works-like-siri/)에 있는 스크립트를 OSX에서 작동하도록 변경

### 필요 프로그램 설치

```
$ brew install sox --with-flac
$ brew install ffmpeg
$ pip install wolframalpha
$ brew install mplayer
```

wolframalpha

http://products.wolframalpha.com/api/ 회원가입하고 AppID 발급 


text2speech.sh 테스트

```
./text2speech.sh "My name is Oscar and I am testing the audio."
```

### 프로그램 실행

```
./main.sh
```

참고 : google 음성인식 API 결과 status 코드 

status: 0 – correct  
status: 4 – missing audio file  
status: 5 – ncorrect audio file 


### TODO 

silence detection
http://unix.stackexchange.com/questions/55032/end-sox-recording-once-silence-is-detected

