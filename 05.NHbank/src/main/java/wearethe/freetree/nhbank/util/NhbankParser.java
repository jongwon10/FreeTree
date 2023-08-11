package wearethe.freetree.nhbank.util;

import com.google.gson.JsonObject;
import lombok.Data;
@Data
public class NhbankParser {
    private String Vran;            //계좌번호
    private String MnrcStts;        //입금상태: 1:정상, 0:처리중, 9:오류
    private String MnrcDt;          //입금일자
    private String MnrcAmt;         //입금금액

    public NhbankParser(JsonObject jsonObject) {
        parseJson(jsonObject);
        System.out.println("<< NhbankParser >>");
    }

    private void parseJson(JsonObject jsonObject) {
        // 파서
        Vran = jsonObject.get("Vran").getAsString();
        MnrcStts = jsonObject.get("MnrcStts").getAsString();
        MnrcDt = jsonObject.get("MnrcDt").getAsString();
        MnrcAmt = jsonObject.get("MnrcAmt").getAsString();

        // 로그
        System.out.println("Parsed values:");
        System.out.println("Vran: " + Vran);
        System.out.println("MnrcStts: " + MnrcStts);
        System.out.println("MnrcDt: " + MnrcDt);
        System.out.println("MnrcAmt: " + MnrcAmt);
    }
}