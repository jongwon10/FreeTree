package wearethe.freetree.project.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wearethe.freetree.company.vo.CompanyVO;
import wearethe.freetree.mybatis.mapper.ProjectMapper;
import wearethe.freetree.project.vo.ProjectSupportVO;
import wearethe.freetree.project.vo.ProjectVO;

import java.util.List;
import java.util.Map;

@Service
public class ProjectServiceImpl implements ProjectService {

    ProjectMapper projectMapper;

    @Autowired
    public ProjectServiceImpl(ProjectMapper projectMapper)
    {this.projectMapper = projectMapper;}


    @Override
    public List<ProjectVO> projectMainSelectAll(Map<String, Object> params) {

        return projectMapper.projectMainSelectAll(params);
    }



    @Override
    public List<ProjectVO> projectInfo(ProjectVO pvo) {

        return projectMapper.projectInfo(pvo);
    }

    public List<CompanyVO> projectinsertgo(CompanyVO cvo) {

        return projectMapper.projectinsertgo(cvo);
    }

    @Override
    public int getProjectInsert(ProjectVO pvo) {

        return projectMapper.getProjectInsert(pvo);
    }

    @Override
    public int totalResult(ProjectVO pvo) {
        return projectMapper.totalResult(pvo);
    }


    // 지원
    @Override
    public int projectSupportInsert(ProjectSupportVO psvo) {
        return projectMapper.projectSupportInsert(psvo);
    }

    @Override
    public int projectSupportcnt(ProjectSupportVO psvo) {

        return projectMapper.projectSupportcnt(psvo);
    }

    @Override
    public List<ProjectSupportVO> projectSupportSelectAll(ProjectSupportVO psvo) {
        return projectMapper.projectSupportSelectAll(psvo);
    }

    @Override
    public List<ProjectSupportVO> projectSupportSelect(ProjectSupportVO psvo) {
        return projectMapper.projectSupportSelect(psvo);
    }

    /* 프로젝트 지원하기 클릭시 selectAll 진입 */
    @Override
    public List<ProjectSupportVO> projectInfoSelectAll(ProjectSupportVO psvo) {
        return projectMapper.projectInfoSelectAll(psvo);
    }

    /* 프로젝트 신청자 목록 */
    @Override
    public int projectManageDelete(ProjectSupportVO psvo) {
        return projectMapper.projectManageDelete(psvo);
    }

    /*프로젝트 참여자 목록*/
    @Override
    public List<ProjectSupportVO> projectSupportPartSelectAll(ProjectSupportVO psvo) {
        return projectMapper.projectSupportPartSelectAll(psvo);
    }


}
