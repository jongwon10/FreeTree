package wearethe.freetree.question.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wearethe.freetree.mybatis.mapper.QuestionMapper;
import wearethe.freetree.question.vo.QuestionVO;

import java.util.List;

@Service
public class QuestionServiceImpl implements QuestionService {
    QuestionMapper questionMapper;
    @Autowired
    public QuestionServiceImpl(QuestionMapper questionMapper){
        this.questionMapper = questionMapper;
    }

    @Override
    public int questionInsert(QuestionVO qvo) {
        return questionMapper.questionInsert(qvo);
    }
   @Override
    public List<QuestionVO> questionSelectAll() {
        return questionMapper.questionSelectAll();
    }
    @Override
    public List<QuestionVO> questionSelect(QuestionVO qvo) {
        return questionMapper.questionSelect(qvo);
    }
      @Override
    public int questionDelete(QuestionVO qvo) {
        return questionMapper.questionDelete(qvo);
    }
 }
