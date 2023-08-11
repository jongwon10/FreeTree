package wearethe.freetree.question.service;
import wearethe.freetree.company.vo.CompanyVO;
import wearethe.freetree.member.vo.MemberVO;
import wearethe.freetree.question.vo.QuestionVO;

import java.util.List;

public interface QuestionService {

    int questionInsert(QuestionVO qvo);
    List<QuestionVO> questionSelectAll();
    List<QuestionVO> questionSelect(QuestionVO qvo);
    int questionDelete(QuestionVO qvo);

    List<MemberVO> memberSelect(MemberVO mvo);

    List<CompanyVO> companySelect(CompanyVO cvo);
}
