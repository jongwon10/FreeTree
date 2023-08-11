package wearethe.freetree.member.vo;

import lombok.*;
import wearethe.freetree.account.vo.TempIdVO;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemberVO {

    private String mnum;
    private String memail;
    private String mpw;
    private String mname;
    private String mhp;
    private String mbirth;
    private String mgender;
    private String mnick;
    private String minfodate;
    private String msns;
    private String mterms;
    private String mregister;
    private String mleave;
    private String mphoto;
    private String mresume;
    private String mresumemain;

    // id 찾기 변수
    private TempIdVO tempidVO;

    String num;
    String id;
    String pw;
    String name;

}