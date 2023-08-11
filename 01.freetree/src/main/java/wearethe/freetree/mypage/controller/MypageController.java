package wearethe.freetree.mypage.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import wearethe.freetree.mypage.vo.ComPageVO;
import wearethe.freetree.project.vo.ProjectSupportVO;
import wearethe.freetree.project.vo.ProjectVO;
import wearethe.freetree.util.FileUpload;
import wearethe.freetree.member.vo.MemberVO;
import wearethe.freetree.mypage.service.MemMypageSerivce;
import wearethe.freetree.mypage.vo.MemMypageVO;
import wearethe.freetree.mypage.vo.ResumeVO;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/")
public class MypageController {

    private final MemMypageSerivce memMypageSerivce;


    @Autowired
    public MypageController(MemMypageSerivce memMypageSerivce) {

        this.memMypageSerivce = memMypageSerivce;
    }

    /*개인 마이페이지 =========================================*/
    @RequestMapping("/memMypageForm")
    public String memMypageForm(MemberVO mvo, Model model,HttpServletRequest req, MemMypageVO mmvo) {

        mmvo.setMnum(req.getParameter("userId"));
        System.out.println("mmvo세팅 " + mmvo.getMnum());

        List<MemMypageVO> ulist = memMypageSerivce.memMypageSelect(mmvo);

        if (ulist.size() > 0 ) {
            System.out.println("list 들어와라");

            model.addAttribute("ulist", ulist);
            return "mypage/memMypageUpdate";
        }else {
            mvo.setMnum(req.getParameter("userId"));
            System.out.println("mvo세팅 " + mvo.getMnum());
            List<MemberVO> list = memMypageSerivce.memberSelect(mvo);

            model.addAttribute("list", list);
            return "mypage/memMypage";
        }

    }

    // 입력
    @RequestMapping("/memmypage")
    public String memMypageInsert(@RequestParam("mpfileup") ArrayList<MultipartFile> files, HttpServletRequest req, Model model) {
        System.out.println("memmypageInsert >>> : ");
        //파일 이미지 업로드 정보
        //String BOARD_IMG_UPLOAD_PATH = "C:\\00.KOSMO129\\30.web\\el_kos_spring_work\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\kosSpring\\fileupload\\board";

        String BOARD_IMG_UPLOAD_PATH = "C:\\00.KOSMO129\\70.FreeTree\\freetree_0.0.4\\src\\main\\resources\\static\\upload";
        int BOARD_IMG_FILE_SIZE = 10*1024*1024; // 10MB
        String BOARD_EN_CODE = "UTF-8";
        FileUpload fu = new FileUpload(BOARD_IMG_UPLOAD_PATH, BOARD_IMG_FILE_SIZE, BOARD_EN_CODE);
        //이미지 파일 원본 사이즈
        boolean bool = fu.imgfileUpload(req);

        // VO
        MemMypageVO mmvo = null;
        mmvo = new MemMypageVO();

        mmvo.setMnum(req.getParameter("mnum"));
        mmvo.setMname(req.getParameter("mname"));
        mmvo.setMemail(req.getParameter("memail"));
        mmvo.setMpposition(req.getParameter("mpposition"));
        mmvo.setBankname(req.getParameter("bankname"));
        mmvo.setBankan(req.getParameter("bankan"));
        mmvo.setMpgit(req.getParameter("mpgit"));
        mmvo.setMpinstar(req.getParameter("mpinstar"));
        mmvo.setMpinfo(req.getParameter("mpinfo"));

        // 로그
        System.out.println("mmvo.getMnum() >>> : " + mmvo.getMnum());
        System.out.println("mmvo.getMname() >>> : " + mmvo.getMname());
        System.out.println("mmvo.getMemail() >>> : " + mmvo.getMemail());
        System.out.println("mmvo.getMpposition() >>> : " + mmvo.getMpposition());
        System.out.println("mmvo.getBankname() >>> : " + mmvo.getBankname());
        System.out.println("mmvo.getBankan() >>> : " + mmvo.getBankan());
        System.out.println("mmvo.getMpgit() >>> : " + mmvo.getMpgit());
        System.out.println("mmvo.getMpinstar() >>> : " + mmvo.getMpinstar());
        System.out.println("mmvo.getMpinfo() >>> : " + mmvo.getMpinfo());

        String fileNames = FileUpload.getFileNames(files, BOARD_IMG_UPLOAD_PATH);
        mmvo.setMpfileup(fileNames);
        System.out.println("mmvo.getMpfileup() >>> : " + mmvo.getMpfileup());

        int nCnt = memMypageSerivce.memMypageInsert(mmvo);
        String mnum = req.getParameter("mnum");
        if (nCnt > 0) {

            model.addAttribute("mnum", mnum);
            return "mypage/memMypageSuccess";
        }
        return "";
    }

    // 전체 조회
    @RequestMapping("/memMypageSelectAll")
    public String memSelectAll(Model model, HttpServletRequest req, @RequestParam(defaultValue = "1") int currentPage, MemMypageVO mmvo) {
        System.out.println("memSelectAll() 함수 진입 >>> : ");
        mmvo.setSearch(req.getParameter("search"));
        int resultsPerPage = 9; // 페이지당 결과 수
        int totalResults = memMypageSerivce.totalResult(mmvo);
        int pageRange = 5; // 페이지 범위 (페이지 번호를 몇 개씩 보여줄지)
        int totalPages = (int) Math.ceil((double) totalResults / resultsPerPage); // 전체 페이지 수
        int startPage = ((currentPage - 1) / pageRange) * pageRange + 1; // 시작 페이지 번호
        int endPage = Math.min(startPage + pageRange - 1, totalPages); // 끝 페이지 번호

        int offset = (currentPage - 1) * resultsPerPage; // offset 값 계산

        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("search", req.getParameter("search"));


        List<MemMypageVO> listAll = memMypageSerivce.memMypageSelectAll(params);
        int nCnt = listAll.size();
        System.out.println("nCnt" + nCnt);

        // 페이지 범위 동적 조정
        if (nCnt == 0) {
            // 현재 페이지에 결과가 없는 경우 페이지 범위를 줄임
            int adjustedPageRange = pageRange - 1; // 조정된 페이지 범위
            int adjustedStartPage = Math.max(startPage - 1, 1); // 조정된 시작 페이지
            int adjustedEndPage = Math.min(adjustedStartPage + adjustedPageRange - 1, totalPages); // 조정된 끝 페이지
            startPage = adjustedStartPage;
            endPage = adjustedEndPage;
        }

        if (nCnt > 0) {

            model.addAttribute("listAll", listAll);
        }

        System.out.println(">>>"+totalResults);
        System.out.println(">>>"+currentPage);
        System.out.println(">>>"+startPage);
        System.out.println(">>>"+endPage);
        System.out.println(">>>"+totalPages);

        model.addAttribute("totalResults", totalResults);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("startPage", startPage);
        model.addAttribute("endPage", endPage);
        model.addAttribute("totalPages", totalPages);


        return "mypage/memMypageSelectAll";
    }

    // 조회
    @RequestMapping(value="/memMypageSelect")
    public String memMypageSelect(HttpServletRequest req, Model model, MemberVO mvo, ResumeVO rvo, ProjectSupportVO psvo) {
        System.out.println("memMypageSelect 함수 진입 >>> : ");

        MemMypageVO mmvo = new MemMypageVO();
        mmvo.setMnum(req.getParameter("mnum"));

        List<ProjectSupportVO> plist = memMypageSerivce.proSelect(psvo);
        List<ProjectSupportVO> elist = memMypageSerivce.endSelect(psvo);
        List<MemMypageVO> ulist = memMypageSerivce.memMypageSelect(mmvo);
        if(ulist.size() > 0 ){
            List<ResumeVO> rlist = memMypageSerivce.resumeSelect(rvo);

            model.addAttribute("rlist", rlist);
            model.addAttribute("ulist", ulist);
            model.addAttribute("plist", plist);
            model.addAttribute("elist", elist);

            return "mypage/memMypageSelect";
        }else{

            mvo.setMnum(req.getParameter("mnum"));
            System.out.println("mvo세팅 " + mvo.getMnum());
            List<MemberVO> list = memMypageSerivce.memberSelect(mvo);

            model.addAttribute("list", list);
            return "mypage/memMypage";

        }

    }



    // 수정
    @RequestMapping("/memMypageUpdate")
    public String memMypageUpdate(@RequestParam("mpfileup") ArrayList<MultipartFile> files, HttpServletRequest req, Model model) {
        System.out.println("memmypageUpdateForm >>> : ");

        //파일 이미지 업로드 정보
        String BOARD_IMG_UPLOAD_PATH = "C:\\00.KOSMO129\\70.FreeTree\\freetree_0.0.4\\src\\main\\resources\\static\\upload";
        int BOARD_IMG_FILE_SIZE = 10*1024*1024; // 10MB
        String BOARD_EN_CODE = "UTF-8";
        FileUpload fu = new FileUpload(BOARD_IMG_UPLOAD_PATH, BOARD_IMG_FILE_SIZE, BOARD_EN_CODE);
        //이미지 파일 원본 사이즈
        boolean bool = fu.imgfileUpload(req);

        // VO
        MemMypageVO mmvo = new MemMypageVO();

        mmvo.setMnum(req.getParameter("userId"));
        mmvo.setMpposition(req.getParameter("mpposition"));
        mmvo.setBankname(req.getParameter("bankname"));
        mmvo.setBankan(req.getParameter("bankan"));
        mmvo.setMpgit(req.getParameter("mpgit"));
        mmvo.setMpinstar(req.getParameter("mpinstar"));
        mmvo.setMpinfo(req.getParameter("mpinfo"));


        // 로그
        System.out.println("mmvo.getMnum() >>> : " + mmvo.getMnum());
        System.out.println("mmvo.getMname() >>> : " + mmvo.getMname());
        System.out.println("mmvo.getMemail() >>> : " + mmvo.getMemail());
        System.out.println("mmvo.getMpposition() >>> : " + mmvo.getMpposition());
        System.out.println("mmvo.getBankname() >>> : " + mmvo.getBankname());
        System.out.println("mmvo.getBankan() >>> : " + mmvo.getBankan());
        System.out.println("mmvo.getMpgit() >>> : " + mmvo.getMpgit());
        System.out.println("mmvo.getMpinstar() >>> : " + mmvo.getMpinstar());
        System.out.println("mmvo.getMpinfo() >>> : " + mmvo.getMpinfo());

        String fileNames = FileUpload.getFileNames(files, BOARD_IMG_UPLOAD_PATH);
        mmvo.setMpfileup(fileNames);
        System.out.println("mmvo.getMpfileup() >>> : " + mmvo.getMpfileup());

        int nCnt = memMypageSerivce.memMypageUpdate(mmvo);
        String mnum = req.getParameter("mnum");
        if (nCnt > 0) {

            model.addAttribute("mnum", mnum);
            return "mypage/memMypageSuccess";
        }

        return "mypage/memMypageUpdate";
    }


    /*이력서 ===============================================*/
    @RequestMapping("/resumeForm")
    public String resumeForm(MemMypageVO mmvo, ResumeVO rvo, Model model, HttpServletRequest req, ProjectSupportVO psvo) {

        rvo.setMnum(req.getParameter("mnum"));
        List<ResumeVO> rlist = memMypageSerivce.resumeSelect(rvo);
        if(rlist.size() > 0) {
            List<MemMypageVO> mlist = memMypageSerivce.memMypageSelect(mmvo);
            List<ProjectSupportVO> plist = memMypageSerivce.proSelect(psvo);
            List<ProjectSupportVO> elist = memMypageSerivce.endSelect(psvo);

            model.addAttribute("mlist", mlist);
            model.addAttribute("rlist", rlist);
            model.addAttribute("plist", plist);
            model.addAttribute("elist", elist);
            return "mypage/resumeSelect";
        }else{
            List<MemMypageVO> list = memMypageSerivce.memMypageSelect(mmvo);
            System.out.println("list 들어와라");
            model.addAttribute("list", list);

            return "mypage/resumeForm";
        }
    }

    // 입력
    @RequestMapping("/resumeInsert")
    public String resumeInsert(HttpServletRequest req, ResumeVO rvo, Model model) {
        System.out.println("resumeInsert() >>> : ");

        // 로그
        System.out.println("rvo.getRnum() >>> : " + rvo.getRnum());
        System.out.println("rvo.getRtitle() >>> : " + rvo.getRtitle());
        System.out.println("rvo.getRname() >>> : " + rvo.getRname());
        System.out.println("rvo.getRengname() >>> : " + rvo.getRengname());
        System.out.println("rvo.getRbirth() >>> : " + rvo.getRbirth());
        System.out.println("rvo.getRhp() >>> : " + rvo.getRhp());
        System.out.println("rvo.getRaddr() >>> : " + rvo.getRaddr());
        System.out.println("rvo.getRperiod() >>> : " + rvo.getRperiod());
        System.out.println("rvo.getRschname() >>> : " + rvo.getRschname());
        System.out.println("rvo.getRmajor() >>> : " + rvo.getRmajor());
        System.out.println("rvo.getRtenure() >>> : " + rvo.getRtenure());
        System.out.println("rvo.getRrespons() >>> : " + rvo.getRrespons());
        System.out.println("rvo.getRworkname() >>> : " + rvo.getRworkname());
        System.out.println("rvo.getRacqui() >>> : " + rvo.getRacqui());
        System.out.println("rvo.getRlicense() >>> : " + rvo.getRlicense());
        System.out.println("rvo.getRpublisher() >>> : " + rvo.getRpublisher());

        int nCnt = memMypageSerivce.resumeInsert(rvo);
        String mnum = req.getParameter("mnum");
        if (nCnt > 0 ) {
            model.addAttribute("mnum", mnum);
            return "mypage/resumeSuccess";
        }
        return "";
    }

    // 조회
    @RequestMapping("/resumeSelect")
    public String resumeSelect(HttpServletRequest req, ResumeVO rvo, MemMypageVO mmvo, Model model, ProjectSupportVO psvo) {

        mmvo.setMnum(req.getParameter("mnum"));
        rvo.setRnum(req.getParameter("rnum"));


        List<ProjectSupportVO> plist = memMypageSerivce.proSelect(psvo);
        List<ProjectSupportVO> elist = memMypageSerivce.endSelect(psvo);
        List<ResumeVO> rlist = memMypageSerivce.resumeSelect(rvo);
        List<MemMypageVO> mlist = memMypageSerivce.memMypageSelect(mmvo);

        if (rlist.size() == 1) {
            model.addAttribute("rlist", rlist);
            model.addAttribute("mlist", mlist);
            model.addAttribute("elist", elist);
            model.addAttribute("plist", plist);


            return "mypage/resumeSelect";
        }
        return "mypage/memMypageSelectAll";
    }

    // 수정 폼
    @RequestMapping("/resumeUpdateForm")
    public String resumeUpdateForm(HttpServletRequest req, Model model, ResumeVO rvo, MemMypageVO mmvo) {
        System.out.println("resumeUpdateForm 여기냐? >>> : ");
        rvo.setRnum(req.getParameter("rnum"));
        rvo.setMnum(req.getParameter("mnum"));

        List<ResumeVO> rlist = memMypageSerivce.resumeSelect(rvo);
        List<MemMypageVO> mlist = memMypageSerivce.memMypageSelect(mmvo);

        model.addAttribute("rlist", rlist);
        model.addAttribute("mlist", mlist);

        return "mypage/resumeUpdate";
    }

    // 수정
    @RequestMapping("/resumeUpdate")
    public String resumeUpdate(HttpServletRequest req, ResumeVO rvo, Model model) {
        System.out.println("resumeUpdate()lllllkjjjj >>> :");

        // 로그
        System.out.println("rvo.getRnum() >>> : " + rvo.getRnum());
        System.out.println("rvo.getRhp() >>> : " + rvo.getRhp());
        System.out.println("rvo.getRaddr() >>> : " + rvo.getRaddr());
        System.out.println("rvo.getRperiod() >>> : " + rvo.getRperiod());
        System.out.println("rvo.getRschname() >>> : " + rvo.getRschname());
        System.out.println("rvo.getRmajor() >>> : " + rvo.getRmajor());
        System.out.println("rvo.getRtenure() >>> : " + rvo.getRtenure());
        System.out.println("rvo.getRrespons() >>> : " + rvo.getRrespons());
        System.out.println("rvo.getRworkname() >>> : " + rvo.getRworkname());
        System.out.println("rvo.getRacqui() >>> : " + rvo.getRacqui());
        System.out.println("rvo.getRlicense() >>> : " + rvo.getRlicense());
        System.out.println("rvo.getRpublisher() >>> : " + rvo.getRpublisher());

        int nCnt = memMypageSerivce.resumeUpdate(rvo);
        String mnum = req.getParameter("mnum");
        String rnum = req.getParameter("rnum");
        model.addAttribute("mnum", mnum);
        model.addAttribute("rnum", rnum);

        return "mypage/resumeSuccess";
    }




    // 임시 기업 마이페이지
    @RequestMapping("/myComSelect")
    public String myComselect(HttpServletRequest req, ProjectVO pvo, Model model) {
        System.out.println("기업 마이페이지");

        pvo.setCnum(req.getParameter("cnum"));
        System.out.println(">><<><" + pvo.getCnum());
        List<ProjectVO> list = memMypageSerivce.myComSelect(pvo);

        model.addAttribute("list", list);


        return "mypage/myCompage";
    }


    // 성호형 기업 마이페이지
    @RequestMapping("/compage")
    public String getComPage(Model model, ComPageVO cpvo, HttpServletRequest req, ProjectVO pvo) {
        System.out.println("기업 마이페이지 진입");

        cpvo.setCnum(req.getParameter("cnum"));
        pvo.setCnum(req.getParameter("cnum"));
        // ComPageService를 통해 데이터베이스에서 데이터를 조회합니다.
        List<ComPageVO> compageList = memMypageSerivce.ComPageForm(cpvo);
        List<ProjectVO> prolist = memMypageSerivce.myComSelect(pvo);

        model.addAttribute("prolist", prolist);
        model.addAttribute("compageList", compageList);

        return "mypage/compage";
    }

    @GetMapping("/compageupdateform")
    public String ComPageUpdateForm(@RequestParam String cnum, Model model, ComPageVO cpvo) {
        System.out.println("기업 업데이트 페이지 진입");
        cpvo.setCnum("C202307190001");
        System.out.println("1111111");
        // ComPageService를 통해 데이터베이스에서 데이터를 조회합니다.
        List<ComPageVO> compageList = memMypageSerivce.ComPageUpdateForm(cpvo);

        System.out.println("2111111");



        model.addAttribute("compageList", compageList);

        return "mypage/compageupdate";
    }

    @PostMapping("/ComPageUpdate")
    public String ComPageUpdate(@RequestParam("cnum") String cnum, @RequestParam(value="cprofileimg", required=false)
    ArrayList<MultipartFile> files, HttpServletRequest req,
                                @ModelAttribute ComPageVO cpvo, Model model) {
        System.out.println("기업 업데이트 작업 시작");

        cpvo.setCnum(req.getParameter("cnum"));
        cpvo.setCinfo(req.getParameter("cinfo"));
        cpvo.setCpw(req.getParameter("cpw"));
        cpvo.setCprofileimg(req.getParameter("cprofileimg"));

        String cprofile = cpvo.getCprofileimg();
        String cinfo = cpvo.getCinfo(); // 사용자가 입력한 HTML 내용인 cinfo 값을 가져온다.

        // 파일 업로드 처리
        if (files != null && !files.isEmpty()) {
            System.out.println("if문 진입");
            String CPROFILE_IMG_UPLOAD_PATH = "C:\\00.KOSMO129\\01.FreeTree\\freetree_0.0.4\\src\\main\\resources\\static\\cprofileimg";
            int CPROFILE_IMG_FILE_SIZE = 10 * 1024 * 1024; // 10MB
            String CPROFILE_EN_CODE = "UTF-8";

            FileUpload fu = new FileUpload(CPROFILE_IMG_UPLOAD_PATH, CPROFILE_IMG_FILE_SIZE, CPROFILE_EN_CODE);
            String fileNames = fu.getFileNames(files, CPROFILE_IMG_UPLOAD_PATH);

            // 파일 업로드 성공한 경우에는 업로드된 파일명들을 ComPageVO 객체에 설정합니다.
            cpvo.setCprofileimg(fileNames);
        }

        System.out.println("cprofileimg" + cprofile);
        System.out.println("cinfo" + cinfo);
        memMypageSerivce.ComPageUpdate(cpvo);

        System.out.println("기업 업데이트 작업 끝");
        return "view/mypage/compage";
    }

}
