package wearethe.freetree.mypage.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ResumeVO {

    private String rnum; // 이력서 번호 채번
    private String rtitle; // 이력서 제목
    private String insertdate; // 등록일
    private String updatedate; // 수정일
    private String rdelete; // 삭제여부
    private String rname; // 성함
    private String rengname; // 영문이름
    private String rbirth; // 생년월일
    private String rhp; // 휴대폰
    private String raddr; // 주소
    private String rperiod; // 재학 기간
    private String rschname; // 학교명
    private String rmajor; // 전공명
    private String rtenure; // 근무 기간
    private String rrespons; // 담당 업무
    private String rworkname; // 직장명
    private String racqui; // 취득일
    private String rlicense; // 자격증/면허증
    private String rpublisher; // 발행처
    private String pnum; // 프로젝트 번호
    private String mnum; // 회원 번호
    private String mpinfo; // 마이페이지 소개서
    private String mpfileup; // 마이페이지 첨부파일

    String pname; // 프로젝트 제목
    String pstartdate; // 프로젝트 시작일
    String penddate; // 프로젝트 종료일
}
