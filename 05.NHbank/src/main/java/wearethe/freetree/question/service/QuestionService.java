package wearethe.freetree.question.service;
import wearethe.freetree.question.vo.QuestionVO;

import java.util.List;

public interface QuestionService {

    int questionInsert(QuestionVO qvo);
    List<QuestionVO> questionSelectAll();
    List<QuestionVO> questionSelect(QuestionVO qvo);
    int questionDelete(QuestionVO qvo);
}
