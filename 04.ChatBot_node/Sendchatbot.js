const axios = require('axios');

async function callOpenAICompletions(contentValue) {
  try {
    const apiUrl = 'https://api.openai.com/v1/completions';
    const OPENAI_API_KEY = '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';

    const basicMsg = '<답변을 위해 GPT에게 제공하는 데이터 >' +
      '우리 기업은 IT 아웃소싱 플랫폼 "FREE TREE" 입니다. ' +
      '프로젝트 진행시 수수료 책정을 전체 임금의 7.5%를 기준으로 하고있습니다. ' +
      '수수료는 프로젝트를 등록한 사업자가 프로젝트 전체 임금의 10%를 FreeTree에게, 개인에게 2.5%를 뗀 후, 프로젝트가 종료될 때 사업자에게 2.5%를 환급, 개인에게 2.5%를 환급 해줍니다.' +
      '계약 체결 시 클라이언트가 프리트리에 예치한 대금을 프로젝트가 끝날 때까지 안전하게 보호하며, 완료 후 파트너에게 대금을 지급합니다. ' +
      '또한 임금은 개시일을 기준으로 1달마다 지급이 됩니다. (매월 1일) ' +
      '[수수료 결제 수단 - 삼성페이/토스페이/휴대폰결제/실시간계좌이체], ' +
      '[계약금 예치 수단 - NH가상계좌] '+
      '이상의 정보를 가지고 질문자에게 답변을 부탁드립니다. ';

    const ruleMsg = '<필수적으로 지켜야할 사항 > ' +
      ' - 질문에 대한 답변시 ' +
      '제공한 데이터 안에서 답변을 제공 할 수 없는 질문을 한다면 ' +
      ' "고객센터로 문의해주세요"라는 답변을 해 주세요. ';

    const userMsg = '<USER의 질문 > '; // userMsg는 빈 문자열로 초기화

    const headers = {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${OPENAI_API_KEY}`
    };

    const data = {
      model: 'text-davinci-003',
      prompt: basicMsg + ruleMsg + userMsg + contentValue,
      max_tokens: 3000,
      temperature: 0
    };

    const response = await axios.post(apiUrl, data, { headers });
    const choicesText = response.data.choices[0].text; // choices 안의 첫번째 값의 text를 추출
    console.log('sendchatbot.js : ',choicesText);
    return choicesText;

  } catch (error) {
    console.error('Error calling OpenAI API:', error.message);
    throw error; // 오류를 다시 던집니다.
  }
}

module.exports = callOpenAICompletions; // 함수를 외부로 공개합니다.