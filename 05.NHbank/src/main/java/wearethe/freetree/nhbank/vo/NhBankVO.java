package wearethe.freetree.nhbank.vo;

import lombok.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class NhBankVO {

    private String nhnum;
    private String vrans;           //계좌번호
    private String sqno;
    private String mnrcstts;        //입금상태: 1:정상, 0:처리중, 9:오류
    private String mnrcdt;          //입금일자
    private String mntmd;
    private String mnChkTm;
    private String mnrcAmt;         //입금금액

    private String nhnum1;
    private String rgno;
    private String tram;
}
