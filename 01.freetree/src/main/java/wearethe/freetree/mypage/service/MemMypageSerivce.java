package wearethe.freetree.mypage.service;

import wearethe.freetree.member.vo.MemberVO;
import wearethe.freetree.mypage.vo.ComPageVO;
import wearethe.freetree.mypage.vo.MemMypageVO;
import wearethe.freetree.mypage.vo.ResumeVO;
import wearethe.freetree.project.vo.ProjectSupportVO;
import wearethe.freetree.project.vo.ProjectVO;

import java.util.List;
import java.util.Map;

public interface MemMypageSerivce {

    // 개인 마이페이지
    int memMypageInsert(MemMypageVO mmvo);
    List<MemMypageVO> memMypageSelectAll(Map<String, Object> params);
    List<MemMypageVO> memMypageSelect(MemMypageVO mmvo);
    List<MemberVO> memberSelect(MemberVO mvo);
    int memMypageUpdate(MemMypageVO mmvo);

    // 페이징 및 검색
    int totalResult(MemMypageVO mmvo);

    // 이력서 ISUD
    int resumeInsert(ResumeVO rvo);
    List<ResumeVO> resumeSelect(ResumeVO rvo);
    int resumeUpdate(ResumeVO rvo);

    // 프로젝트
    List<ProjectSupportVO> proSelect(ProjectSupportVO psvo);
    List<ProjectSupportVO> endSelect(ProjectSupportVO psvo);


    // 임시기업 마이페이지
    List<ProjectVO> myComSelect(ProjectVO pvo);

    // 성호형 기업 마이페이지
    List<ComPageVO> ComPageForm(ComPageVO cpvo);

    int ComPageUpdate(ComPageVO cpvo);

    List<ComPageVO> ComPageUpdateForm(ComPageVO cpvo);

}
