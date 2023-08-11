package wearethe.freetree.member.service;

import wearethe.freetree.member.vo.MemberVO;

import java.util.List;

public interface MemberService {

    int getMemberInsert(MemberVO mvo);
    List<MemberVO> memberSelect(MemberVO mvo);
}