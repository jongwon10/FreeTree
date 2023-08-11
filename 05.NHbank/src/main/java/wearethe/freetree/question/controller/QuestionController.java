package wearethe.freetree.question.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import wearethe.freetree.common.FileUpload;
import wearethe.freetree.question.service.QuestionService;
import wearethe.freetree.question.vo.QuestionVO;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller

public class QuestionController {

    private final QuestionService questionService;

    @Autowired
    public QuestionController(QuestionService questionService) {
        this.questionService = questionService;
    }
    @GetMapping("/questionForm")
    public String questionForm() {

        System.out.println(" >>>>>>>>>>>> ");
        return "question/questionForm";
    }

    @PostMapping("/questionInsert")
    public String questionInsert(@RequestParam("qfile") ArrayList<MultipartFile> files, HttpServletRequest req){

        //채번으로 qnum해야됨
        //파일 이미지 업로드 정보
        //String BOARD_IMG_UPLOAD_PATH = "C:\\00.KOSMO129\\30.web\\el_kos_spring_work\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\kosSpring\\fileupload\\board";

        String BOARD_IMG_UPLOAD_PATH = "C:\\00.KOSMO129\\70.FreeTree\\freetree_0.0.4\\src\\main\\resources\\static\\upload";
        int BOARD_IMG_FILE_SIZE = 10*1024*1024; // 10MB
        String BOARD_EN_CODE = "UTF-8";
        FileUpload fu = new FileUpload(BOARD_IMG_UPLOAD_PATH, BOARD_IMG_FILE_SIZE, BOARD_EN_CODE);
        //이미지 파일 원본 사이즈
        boolean bool = fu.imgfileUpload(req);

        QuestionVO qvo = null;
        qvo = new QuestionVO();
       //HttpServletRequest이거로 파일업로드없어도 되게 하고
        //jsp에 있는 name이랑 연결해서 getParameter()함수로 나머지 값 받기
        String fnum = "0001"; // FNUM 값을 받아옴
        qvo.setFnum(fnum); // QuestionVO 객체에 FNUM 설정
        String paramName = "qname";
        qvo.setQname(fu.getParameter(paramName, req));// Q&A 제목

        paramName = "qcontent";
        qvo.setQcontent(fu.getParameter(paramName, req));// Q&A 질문내용

        paramName = "qanswer";
        qvo.setQanswer(fu.getParameter(paramName, req));// Q&A 답변
        String fileNames = FileUpload.getFileNames(files, BOARD_IMG_UPLOAD_PATH);

        System.out.println(">>>> : " + fileNames);
        qvo.setQfile(fileNames);

        //서비스 호출
        int nCnt = questionService.questionInsert(qvo);
        if(nCnt > 0){
            return "question/questionInsert";
        }
        return "question/questionForm";
    }//end of Question Insert */


    @GetMapping("questionSelectAll")
    public String questionSelectAll(QuestionVO qvo, Model model, HttpServletRequest req)
    {

        //session으로 mid반환
      /*  K_Session ks = K_Session.getInstance();
        String mid = "";
        mid = ks.getSession(req);

        //페이징
        int pageSize =5;
        int groupSize = 5;
        int curPage = 1;
        int totalCount = 0;

        if (qvo.getCurPage() !=null){
            curPage = Integer.parseInt(qvo.getCurPage());
        }

        qvo.setPageSize(String.valueOf(pageSize));
        qvo.setGroupSize(String.valueOf(groupSize));
        qvo.setCurPage(String.valueOf(curPage));
        qvo.setTotalCount(String.valueOf(totalCount));
*/
        // 페이징 처리 ======================================================================================

        //서비스 호출
        List<QuestionVO> listAll = questionService.questionSelectAll();
        if(listAll.size() > 0) {

           // model.addAttribute("pagingQVO", qvo);
            model.addAttribute("listAll", listAll);
            //model.addAttribute("mid", mid);
            return "question/questionSelectAll";
        }
        return "question/questionSelectAll";
    }//end of questionSelectAll

    //게시글 내용 조회
    @GetMapping("questionSelect")
    public String questionSelect(QuestionVO qvo, Model model, HttpServletRequest req) {

        // 서비스 호출
        List<QuestionVO> listS = questionService.questionSelect(qvo);
        if (listS.size() == 1) {

            model.addAttribute("listS", listS);
            return "question/questionSelect";

        }
        return "question/questionSelectAll";

    }//end of questionSelect
    //=======================================================================

    // 게시글 삭제
    @GetMapping("questionDelete")
    public String questionDelete(QuestionVO qvo) {

        int nCnt = questionService.questionDelete(qvo);
        if (nCnt > 0) {
            return "question/questionDelete";
        }
        return "question/questionSelectAll";
    }
    @GetMapping("/faquestion")
    public String faquestion() {
        return "thymeleaf/question/faquestion";
    }

    @GetMapping("/header")
    public String header() {
        return "thymeleaf/common/header";
    }
    @GetMapping("/footer")
    public String footer() {
        return "thymeleaf/common/footer";
    }




}
