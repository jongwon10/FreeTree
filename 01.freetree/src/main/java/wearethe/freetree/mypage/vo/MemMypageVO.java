package wearethe.freetree.mypage.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class MemMypageVO {

    private String mnum; // 회원번호
    private String mname; // 회원이름
    private String memail; // 이메일
    private String mpposition; // 회원기술
    private String bankname; // 은행이름
    private String bankan; // 계좌번호
    private String mpgit; // 깃주소
    private String mpinstar; // 인스타주소
    private String mpinfo; // 소개서
    private String pnum; // 프로젝트번호
    private String mpendproject; // 참여기록
    private String mpfileup; // 파일업로드

    private String search;

    int offset;
    int totalresult;
}
