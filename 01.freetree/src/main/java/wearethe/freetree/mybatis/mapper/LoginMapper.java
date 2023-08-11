package wearethe.freetree.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;
import wearethe.freetree.company.vo.CompanyVO;
import wearethe.freetree.member.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
@Mapper
public interface LoginMapper {

    List<CompanyVO> comLoginCheck(CompanyVO cvo);

    List<MemberVO> memLoginCheck(MemberVO mvo);

    String loginCheck(HttpServletRequest q);

}
