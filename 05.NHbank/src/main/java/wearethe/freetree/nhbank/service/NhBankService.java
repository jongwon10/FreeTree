package wearethe.freetree.nhbank.service;
import org.json.simple.JSONObject;
import wearethe.freetree.nhbank.vo.NhBankVO;

import java.util.Map;

public interface NhBankService {

    //가상계좌 입금내역 조회 결과 DB삽입
    public int depositInsert(NhBankVO nhvo);

    public int accountInsert(NhBankVO nhvo);
    // DB nhnum 채번
    public NhBankVO nhDBCount();
    public NhBankVO nhDBCount1();
    //parser
    public JSONObject getResponseData();

}
