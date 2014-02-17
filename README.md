
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

울프럼 알파(wolfram alpha)

- [울프럼
  알파](http://ko.wikipedia.org/wiki/%EC%9A%B8%ED%94%84%EB%9F%BC_%EC%95%8C%ED%8C%8C)
- http://products.wolframalpha.com/api/ 회원가입하고 AppID 발급 


speech2text.sh 테스트

```
./test-speech2text.sh 
./test-speech2text.sh ko-kr
```

text2speech.sh 테스트

```
./text2speech.sh "My name is Oscar and I am testing the audio."
```

### 프로그램 실행

```
./main.sh
```

참고 : google 음성인식 API 결과 status 코드 

- status 0 : correct  
- status 4 : missing audio file  
- status 5 : ncorrect audio file 


### TODO 

- silence detection
http://unix.stackexchange.com/questions/55032/end-sox-recording-once-silence-is-detected

