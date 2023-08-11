const express = require('express');
const app = express();
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors'); // cors 미들웨어 추가
const callOpenAICompletions = require('./Sendchatbot');

// 파서
app.use(bodyParser.json());

// cors 미들웨어를 모든 라우트에 적용
app.use(cors());

// 정적 파일 서비스 설정
app.use(express.static(path.join(__dirname, './build')));

// 챗 메인화면 
app.get('/chat', function(req, res) {
  
  res.sendFile(path.join(__dirname, './build', 'index.html'));
});

// 클라이언트로부터 메시지를 받아 처리하는 라우트
app.post('/api/messages', async (req, res) => {
  const receivedMsg = req.body;
  
  // 받은 메시지 JSON 객체
  console.log('Received message:', receivedMsg);

  // msg값
  const contentValue = receivedMsg.content;
  console.log('Content Value:', contentValue);

  try {
    // contentValue를 인수로하여 함수 호출하고 응답을 기다림
    var resulttext = await callOpenAICompletions(contentValue);
    console.log('server 응답결과 : ', resulttext);
    
    // 클라이언트에 보낼 응답 데이터로 content 부분만 추출하여 새로운 객체를 만듭니다.
    const responseContent = receivedMsg.content;
    res.json({ content: resulttext });
  } catch (error) {
    console.error('에러 발생: ', error);
    res.status(500).json({ error: '서버 에러 발생' });
  }
});


app.listen(8081, function() {
  console.log('챗봇 서버 실행 8081포트');
});