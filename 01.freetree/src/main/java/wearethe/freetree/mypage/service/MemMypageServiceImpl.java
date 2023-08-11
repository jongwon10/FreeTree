package wearethe.freetree.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wearethe.freetree.member.vo.MemberVO;
import wearethe.freetree.mybatis.mapper.MemMypageMapper;
import wearethe.freetree.mypage.vo.ComPageVO;
import wearethe.freetree.mypage.vo.MemMypageVO;
import wearethe.freetree.mypage.vo.ResumeVO;
import wearethe.freetree.project.vo.ProjectSupportVO;
import wearethe.freetree.project.vo.ProjectVO;

import java.util.List;
import java.util.Map;

@Service
public class MemMypageServiceImpl implements MemMypageSerivce{

    MemMypageMapper memMypageMapper;

    @Autowired
    MemMypageServiceImpl(MemMypageMapper memMypageMapper) {
        this.memMypageMapper = memMypageMapper;
    }

    @Override
    public int memMypageInsert(MemMypageVO mmvo) {
        return memMypageMapper.memMypageInsert(mmvo);
    }

    @Override
    public List<MemMypageVO> memMypageSelectAll(Map<String, Object> params) {
        return memMypageMapper.memMypageSelectAll(params);
    }

    @Override
    public List<MemMypageVO> memMypageSelect(MemMypageVO mmvo) {
        return memMypageMapper.memMypageSelect(mmvo);
    }

    @Override
    public List<MemberVO> memberSelect(MemberVO mvo) {
        return memMypageMapper.memberSelect(mvo);
    }

    @Override
    public int memMypageUpdate(MemMypageVO mmvo) {
        return memMypageMapper.memMypageUpdate(mmvo);
    }

    @Override
    public int totalResult(MemMypageVO mmvo) {
        return memMypageMapper.totalResult(mmvo);
    }

    // 이력서 ISUD
    @Override
    public int resumeInsert(ResumeVO rvo) {
        return memMypageMapper.resumeInsert(rvo);
    }
    @Override
    public List<ResumeVO> resumeSelect(ResumeVO rvo) {
        return memMypageMapper.resumeSelect(rvo);
    }

    @Override
    public int resumeUpdate(ResumeVO rvo) {
        return memMypageMapper.resumeUpdate(rvo);
    }


    // 프로젝트 진행중
    @Override
    public List<ProjectSupportVO> proSelect(ProjectSupportVO psvo) {
        return memMypageMapper.proSelect(psvo);
    }

    @Override
    public List<ProjectSupportVO> endSelect(ProjectSupportVO psvo) {
        return memMypageMapper.endSelect(psvo);
    }

    // 기업
    @Override
    public List<ProjectVO> myComSelect(ProjectVO pvo) {

        return memMypageMapper.myComSelect(pvo);
    }

    // 성호형
    @Override
    public List<ComPageVO> ComPageForm(ComPageVO cpvo) {
        System.out.println("serviceimplComPageForm 진입");
        return memMypageMapper.ComPageForm(cpvo);
    }
    @Override
    public List<ComPageVO> ComPageUpdateForm(ComPageVO cpvo) {
        System.out.println("serviceimplComPageUpdateFrom 진입");
        return memMypageMapper.ComPageUpdateForm(cpvo);
    }

    @Override
    public int ComPageUpdate(ComPageVO cpvo){
        System.out.println("ServiceimplComPageUpdate 진입");
        return memMypageMapper.ComPageUpdate(cpvo);
    }
}
