package wearethe.freetree.member.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wearethe.freetree.member.vo.MemberVO;
import wearethe.freetree.mybatis.mapper.TestMapper;

import java.util.List;

@Service
public class MemberServiceImpl implements MemberService {

    TestMapper testMapper;

    @Autowired
    public MemberServiceImpl(TestMapper testMapper) {
        this.testMapper = testMapper;
    }
    @Override
    public List<MemberVO> getAllMember() {

        System.out.println("getAllMember() 함수 실행");


        return testMapper.getAllMember();
    }
}