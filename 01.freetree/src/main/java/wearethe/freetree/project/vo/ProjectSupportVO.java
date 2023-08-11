package wearethe.freetree.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProjectSupportVO {

    String panum;  // 프로젝트 지원자번호
    String paintro; // 한즐소개
    String pastartdate; // 프로젝트 시작가능일
    String patypework;  // 근무형태
    String pajob;       // 직무선택
    String pacarrer;    // 경력
    String paminpay;  // 최소금액
    String pamaxpay; // 최대금액
    String pnum;    // 프로젝트 번호
    String deleteyn;
    String pname; // 프로젝트 제목
    String pstartdate; // 프로젝트 시작일
    String penddate; // 프로젝트 종료일


    String rnum;  // 이력서 번호
    String mnum;  // 회원번호
    String mpinfo;      // 소개서
    String mpfileup;    // 첨부파일
    String rname; // 성명
    String rengname; // 영문
    String rbirth;  // 생년월일
    String rhp; // 휴대폰
    String raddr;   // 도로명주소
    String rperiod; // 재학기간
    String rschname; // 학교명
    String rmajor;    // 학과
    String rtenure;   // 근무 기간
    String rrespons;   // 업무 내용
    String rworkname;   // 근무처
    String racqui;    // 취득년월일
    String rlicense;     // 자격증및 특기사항 내용
    String rpublisher;    // 발령청


    String pinid;
    String pinyn;
    String pinyes;
    String pindate;






}// end of projectSupportVO class
