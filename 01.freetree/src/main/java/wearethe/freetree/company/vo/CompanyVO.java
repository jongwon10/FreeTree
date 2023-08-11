package wearethe.freetree.company.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CompanyVO {

    private String cnum; //기업회원번호
    private String cemail; // 아이디(이메일)
    private String cpw; // 비밀번호
    private String chp; // 담당자 휴대폰
    private String ctel; // 기업 전화번호
    private String ccomtype; // 기업형태
    private String cbiznum; // 사업자 등록 번호
    private String cname; // 기업명
    private String cpostalcode; // 기업 우편번호
    private String croadaddr; // 기업 도로명 주소
    private String caddr; // 기업 주소
    private String croaddetail; // 기업 상세 주소
    private String cinfodate; // 개인정보 유효기간
    private String cterms; // 약관 동의 여부
    private String cregister; // 가입일
    private String cleave; // 탈퇴 여부
    private String cappro; // 가입승인여부
    private String cpersonnel; //인사담당자 이름
    private String cdelegate; // 대표 이름

}
