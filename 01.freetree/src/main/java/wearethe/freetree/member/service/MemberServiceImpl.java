package wearethe.freetree.member.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wearethe.freetree.member.vo.MemberVO;
import wearethe.freetree.mybatis.mapper.MemberMapper;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberService{

    MemberMapper memberMapper;

    @Autowired
    MemberServiceImpl(MemberMapper memberMapper) {
        this.memberMapper = memberMapper;
    }

    @Override
    public int getMemberInsert(MemberVO mvo) {
        System.out.println("MemberInsert 함수 진입 >>> ");

        return memberMapper.getMemberInsert(mvo);
    }

    @Override
    public List<MemberVO> memberSelect(MemberVO mvo) {
        System.out.println("memberSelect 함수 진입 >>> ");

        return memberMapper.memberSelect(mvo);
    }
}
