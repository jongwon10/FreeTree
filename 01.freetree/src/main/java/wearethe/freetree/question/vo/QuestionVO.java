package wearethe.freetree.question.vo;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class QuestionVO {

    private String qnum;
    private String fnum;
    private String qname;
    private String qcontent;
    private String qfile;
    private String qanswer;
    private String insertdate;
    private String updatedate;
    private String deleteyn;

    //페이징 이동 필드
/*    private String pageSize;
    private String groupSize;
    private String curPage;
    private String totalCount;*/

}
