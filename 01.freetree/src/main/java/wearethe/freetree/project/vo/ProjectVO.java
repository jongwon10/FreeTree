package wearethe.freetree.project.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProjectVO {

    String pnum; // 프로젝트 번호  ok
    String pname; // 프로젝트명  ok
    String pinstartdate; // 모집 개시일 --승인 전까지 일단 null
    String pinenddate; // 모집 종료일 -- 승인 전까지 일단 null
    String pstartdate; // 프로젝트 개시일  ok
    String penddate; // 프로젝트 종료일  ok
    String plimit; // 지원자 상한  ok
    String pintroduction; // 팀소개 ok
    String pwork; // 주요업무 ok
    String pcondition; // 지원조건 ok
    String pdemand; // 우대사항 ok
    String pbenefit; // 혜택 ok
    String pannual; // 연차 ok
    String ppaymin; // 최소 금액  ok
    String ppaymax; // 최대 금액  ok
    String preside; // 상주/비상주 ok
    String pskill; // 요구 스킬  ok
    String pdelete; // 프로젝트 삭제여부  ok
    String pstatus; // 프로젝트 상태  ok
    String pinstatus; // 프로젝트 모집상태  ok
    String pinyes; // 승인된 프리랜서 수 ok
    String cnum; // 기업 회원번호  -- 기업 닭발(받아옴)
    String chp; // 기업 전화번호 -- 기업 닭발(받아옴)

    int offset;
    int totalresult;

    String caddr; // 기업 주소
    String croaddetail; // 기업 상세 주소

    String search;

}
