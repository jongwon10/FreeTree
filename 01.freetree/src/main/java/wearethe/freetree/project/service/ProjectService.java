package wearethe.freetree.project.service;


import wearethe.freetree.company.vo.CompanyVO;
import wearethe.freetree.project.vo.ProjectSupportVO;
import wearethe.freetree.project.vo.ProjectVO;

import java.util.List;
import java.util.Map;

public interface ProjectService {

    List<ProjectVO> projectMainSelectAll(Map<String, Object> params);


    List<ProjectVO> projectInfo(ProjectVO pvo);


    List<CompanyVO> projectinsertgo(CompanyVO cvo);

    int getProjectInsert(ProjectVO pvo);

    int totalResult(ProjectVO pvo);

    // 지원
    int projectSupportInsert(ProjectSupportVO psvo);

    int projectSupportcnt(ProjectSupportVO psvo);

    List<ProjectSupportVO> projectSupportSelectAll(ProjectSupportVO psvo);


    List<ProjectSupportVO> projectSupportSelect(ProjectSupportVO psvo);


    /* 프로젝트 지원하기 클릭시 selectAll 진입 */
    List<ProjectSupportVO> projectInfoSelectAll(ProjectSupportVO psvo);

    /* 프로젝트 신청자 목록 */
    int projectManageDelete(ProjectSupportVO psvo);

    /*프로젝트 참여자 목록*/
    List<ProjectSupportVO> projectSupportPartSelectAll(ProjectSupportVO psvo);



}
