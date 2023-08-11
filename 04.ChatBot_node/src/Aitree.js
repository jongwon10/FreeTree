import React from 'react';
import NewMsg from './newmsg'
import axios from 'axios';
import './App.css';

class Aitree extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
          msgs: [],
        };
        this.addMsg = this.addMsg.bind(this);
    }
    async addMsg() {
        let value = document.querySelector('#new-msg-content').value;
        // 질문
        const newMsg = {
          uuid: this.state.msgs.length + 1,
          writer: '질문',
          date: new Date().toISOString().slice(0, 10),
          content: value,
        };
        // 답변 저장공간
        let resulttext;

        // 서버로 데이터 보내기
        try {
            
          const response = await axios.post('http://192.168.0.5:8081/api/messages', newMsg);
          console.log('서버 응답:', response.data);
          resulttext = response.data.content;
          console.log('resulttext : ',resulttext);
        } catch (error) {
          console.error('에러 발생:', error);
          // 에러 처리
        }
        
        // 답변
        const resultMsg = {
            uuid: this.state.msgs.length + 1,
            writer: '답변',
            date: new Date().toISOString().slice(0, 10),
            content: resulttext,
        };

        // 새 메시지 추가하기
        this.setState((prevState) => ({
          msgs: [...prevState.msgs, newMsg],
        }));
        // 답변 추가하기
        this.setState((prevState) => ({
            msgs: [...prevState.msgs, resultMsg],
        }));
    }
    render(){
        return(
            <div id="root">
                <div>
                    <div class="chatbot_title">FREETREE_CHATBOT(beta)</div>
                    <div id="writing-area">
                        <textarea class="new-msg-content" id="new-msg-content" placeholder='질문을 입력해주세요. 문장의 길이에 따른 대기시간이 존재 할 수 있습니다.'></textarea><br/>
                        <button class="submit-new-msg" id="submit-new-msg" onClick={this.addMsg}>질문하기</button>
                    </div>
                    <div id="msgs">
                        {
                            this.state.msgs.map(msg => {
                                return <NewMsg key={msg.uuid} msg={msg}></NewMsg>
                            })
                        }
                    </div>
                </div>
            </div>
        )
    }
}

export default Aitree;