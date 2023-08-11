package wearethe.freetree.financials.service;

import org.json.simple.JSONObject;
import wearethe.freetree.financials.vo.FinancialsVO;

import java.util.List;

public interface FinancialsService {

    // 결제로직
    public boolean callPaymentAPI(String orderId, String paymentKey, String amount);

    // 결제결과 DB삽입
    public int tosspayapiInsert(FinancialsVO financialsVO);

    // DB tosspnum 채번
    public FinancialsVO tosspayapiDBCount();

    public JSONObject getResponseData();

}
