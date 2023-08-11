package wearethe.freetree.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import wearethe.freetree.member.vo.MemberVO;

@Mapper
public interface TestMapper {

    List<MemberVO> getAllMember();

}