package wearethe.freetree.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;
import wearethe.freetree.question.vo.QuestionVO;

import java.util.List;

@Mapper
public interface QuestionMapper {

    int questionInsert(QuestionVO qvo);

    List<QuestionVO> questionSelectAll();
   List<QuestionVO> questionSelect(QuestionVO qvo);
    int questionDelete(QuestionVO qvo);

}
