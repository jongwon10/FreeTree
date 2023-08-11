package wearethe.freetree.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;
import wearethe.freetree.company.vo.CompanyVO;
import wearethe.freetree.member.vo.MemberVO;
import wearethe.freetree.question.vo.QuestionVO;

import java.util.List;

@Mapper
public interface QuestionMapper {

    int questionInsert(QuestionVO qvo);

    List<QuestionVO> questionSelectAll();
   List<QuestionVO> questionSelect(QuestionVO qvo);
    int questionDelete(QuestionVO qvo);

    List<MemberVO> memberSelect(MemberVO mvo);

    List<CompanyVO> companySelect(CompanyVO cvo);


}
