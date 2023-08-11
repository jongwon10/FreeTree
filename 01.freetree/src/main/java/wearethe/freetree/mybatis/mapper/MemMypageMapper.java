package wearethe.freetree.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;
import wearethe.freetree.member.vo.MemberVO;
import wearethe.freetree.mypage.vo.ComPageVO;
import wearethe.freetree.mypage.vo.MemMypageVO;
import wearethe.freetree.mypage.vo.ResumeVO;
import wearethe.freetree.project.vo.ProjectSupportVO;
import wearethe.freetree.project.vo.ProjectVO;

import java.util.List;
import java.util.Map;

@Mapper
public interface MemMypageMapper {

    int memMypageInsert(MemMypageVO mmvo);
    List<MemMypageVO> memMypageSelectAll(Map<String, Object> params);
    List<MemMypageVO> memMypageSelect(MemMypageVO mmvo);
    List<MemberVO> memberSelect(MemberVO mvo);
    int memMypageUpdate(MemMypageVO mmvo);

    // 검색 및 페이징
    int totalResult(MemMypageVO mmvo);

    // 이력서
    int resumeInsert(ResumeVO rvo);
    List<ResumeVO> resumeSelect(ResumeVO rvo);
    int resumeUpdate(ResumeVO rvo);

    // 프로젝트
    List<ProjectSupportVO> proSelect(ProjectSupportVO psvo);
    List<ProjectSupportVO> endSelect(ProjectSupportVO psvo);


    // 기업
    List<ProjectVO> myComSelect(ProjectVO pvo);

    // 성호형
    int ComPageUpdate(ComPageVO cpvo);
    List<ComPageVO> ComPageForm(ComPageVO cpvo);
    List<ComPageVO> ComPageUpdateForm(ComPageVO cpvo);
}
