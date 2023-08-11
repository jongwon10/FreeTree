package wearethe.freetree.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;
import wearethe.freetree.member.vo.MemberVO;

import java.util.List;

@Mapper
public interface MemberMapper {

    int getMemberInsert(MemberVO mvo);
    List<MemberVO> memberSelect(MemberVO mvo);
}
