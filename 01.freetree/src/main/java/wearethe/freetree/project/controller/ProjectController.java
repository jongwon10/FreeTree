package wearethe.freetree.project.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import wearethe.freetree.alarm.service.AlarmService;
import wearethe.freetree.alarm.vo.AlarmVO;
import wearethe.freetree.company.vo.CompanyVO;
import wearethe.freetree.mypage.service.MemMypageSerivce;
import wearethe.freetree.mypage.vo.MemMypageVO;
import wearethe.freetree.mypage.vo.ResumeVO;
import wearethe.freetree.project.service.ProjectService;
import wearethe.freetree.project.vo.ProjectSupportVO;
import wearethe.freetree.project.vo.ProjectVO;
import wearethe.freetree.util.FileUpload;
import wearethe.freetree.util.K_Session;


import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/")
public class ProjectController {

    private final ProjectService projectService;
    private final MemMypageSerivce memMypageSerivce;

    private final AlarmService alarmService;


    public ProjectController(ProjectService projectService, MemMypageSerivce memMypageSerivce, AlarmService alarmService) { this.projectService = projectService; this.memMypageSerivce = memMypageSerivce; this.alarmService = alarmService;}

    @RequestMapping(value= "/projectmain")
    public String projectMain(Model model, @RequestParam(defaultValue = "1") int currentPage, ProjectVO pvo, HttpServletRequest req ) {
        System.out.println("프로젝트 메인페이지");

        pvo.setSearch(req.getParameter("search"));
        int resultsPerPage = 5; // 페이지당 결과 수
        int totalResults = projectService.totalResult(pvo);
        int pageRange = 5; // 페이지 범위 (페이지 번호를 몇 개씩 보여줄지)
        int totalPages = (int) Math.ceil((double) totalResults / resultsPerPage); // 전체 페이지 수
        int startPage = ((currentPage - 1) / pageRange) * pageRange + 1; // 시작 페이지 번호
        int endPage = Math.min(startPage + pageRange - 1, totalPages); // 끝 페이지 번호

        int offset = (currentPage - 1) * resultsPerPage; // offset 값 계산

        Map<String, Object> params = new HashMap<>();
        params.put("offset", offset);
        params.put("search", req.getParameter("search"));


        List<ProjectVO> listAll = projectService.projectMainSelectAll(params);
        int nCnt = listAll.size();

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
            System.out.println("nCnt >>> " + nCnt);

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

        return "project/project";
    }

    @RequestMapping(value="/projectselect")
    public String projectselect(HttpServletRequest req, ProjectVO pvo, Model model) {


        pvo.setPnum(req.getParameter("pnum"));
        System.out.println("pnum >>> : " + pvo.getPnum());

        pvo.setCnum(req.getParameter("cnum"));
        System.out.println("cnum >>> : " + pvo.getCnum());


        List<ProjectVO> list = projectService.projectInfo(pvo);
        int nCnt = list.size();

        if(nCnt > 0) {
            System.out.println("nCnt >>> " + nCnt);

            model.addAttribute("list", list);
            return "project/projectInfo";
        }

        return "project/projectInfo";
    }

    @RequestMapping(value= "/projectinsertform")
    public String projectForm(HttpServletRequest req, CompanyVO cvo, Model model) {
        System.out.println("프로젝트 인서트폼");

        cvo.setCnum(req.getParameter("cnum"));
        System.out.println("cnum>>>>" + cvo.getCnum());

        List<CompanyVO> list = projectService.projectinsertgo(cvo);

        int nCnt = list.size();
        System.out.println("nCnt >>> " + nCnt);
        if(nCnt > 0) {


            model.addAttribute("list", list);
            return "project/projectInsert";
        }
        return "project/projectInsert";
    }

    @RequestMapping(value= "/projectinsert")
    public String projectInsert(HttpServletRequest req, ProjectVO pvo) {
        System.out.println("프로젝트 등록하는듕~~!!");


            String pnum = "";
            pvo.setPnum(pnum);

            pvo.setPname(req.getParameter("pname"));
            System.out.println("프로젝트 이름 >>> " + pvo.getPname());

            pvo.setPstartdate(req.getParameter("pstartdate"));
            System.out.println("프로젝트 개시일 >>> " + pvo.getPstartdate());


            // penddate의 주 및 개월을 pstartdate에 더하여 설정
            String pstartdate = req.getParameter("pstartdate");
            int count = Integer.parseInt(req.getParameter("when-insert"));
            String day = req.getParameter("day");
            LocalDate startDate = LocalDate.parse(pstartdate);
            if(day.equals("주")) {
               LocalDate enddate = startDate.plusWeeks(count);
                String penddate = enddate.toString();
                pvo.setPenddate(penddate);
            }else {
                LocalDate enddate = startDate.plusMonths(count);
                String penddate = enddate.toString();
                pvo.setPenddate(penddate);
            }
            System.out.println("프로젝트 종료일 >>> " + pvo.getPenddate());

            pvo.setPreside(req.getParameter("preside"));
            System.out.println("근무형태 >>> " + pvo.getPreside());

            pvo.setPpaymin(req.getParameter("ppaymin"));
            System.out.println("최소금액 >>> " + pvo.getPpaymin());

            pvo.setPpaymax(req.getParameter("ppaymax"));
            System.out.println("최대금액 >>> " + pvo.getPpaymax());

            pvo.setPskill(req.getParameter("pskill"));
            System.out.println("요구 기술 >>> " + pvo.getPskill());

            pvo.setPlimit(req.getParameter("plimit"));
            System.out.println("필요 인력 >>> " + pvo.getPlimit());

            pvo.setPannual(req.getParameter("pannual"));
            System.out.println("희망 연차 >>> " + pvo.getPannual());

            pvo.setPintroduction(req.getParameter("pintroduction"));
            System.out.println("팀 소개 >>> " + pvo.getPintroduction());

            pvo.setPwork(req.getParameter("pwork"));
            System.out.println("주요 업무 >>> " + pvo.getPwork());

            pvo.setPcondition(req.getParameter("pcondition"));
            System.out.println("지원 조건 >>> " + pvo.getPcondition());

            pvo.setPdemand(req.getParameter("pdemand"));
            System.out.println("우대 사항 >>> " + pvo.getPdemand());

            pvo.setPbenefit(req.getParameter("pbenefit"));
            System.out.println("혜택 및 복지 >>> " + pvo.getPbenefit());

            pvo.setCnum(req.getParameter("cnum"));
            System.out.println("씨넘 값" + pvo.getCnum());
            pvo.setChp(req.getParameter("chp"));
            pvo.setPstatus("0");
            pvo.setPinstatus("1");
            pvo.setPinyes("0");


            int nCnt = projectService.getProjectInsert(pvo);

            if(nCnt > 0) {
                System.out.print("nCnt >>>" + nCnt);
                return "project/projectnext";
            }

        return "project/projectnext";
    }

    // 프로젝트 지원부터
    @RequestMapping ("/projectSupport")
    public String projectInfoSelectAll(HttpServletRequest req, ProjectSupportVO psvo, Model model, ResumeVO rvo){


        K_Session ks = K_Session.getInstance();
        String mnum = ks.getSession(req);


        System.out.println("세션 가져오기" + mnum);

        rvo.setMnum(mnum);
        List<ResumeVO> rlist = memMypageSerivce.resumeSelect(rvo);
        if(rlist.size() > 0) {
            psvo.setMnum(mnum);
            System.out.println("확인 >> " + psvo.getMnum());
            String pnum = req.getParameter("pnum");
            String cnum = req.getParameter("cnum");
            List<ProjectSupportVO> listAll = projectService.projectInfoSelectAll(psvo);

            model.addAttribute("pnum", pnum);
            model.addAttribute("cnum", cnum);
            model.addAttribute("listAll", listAll);

            return "project/projectSupport";

        }else {

            return "project/projectSupportErr";
        }

    }


    /*프로젝트 지원하기 등록*/
    @RequestMapping ("projectSupportInsert")
    public  String projectSupportInsert(HttpServletRequest req, ProjectSupportVO psvo, AlarmVO avo){

        psvo.setPnum(req.getParameter("pnum"));

        psvo.setMnum(req.getParameter("mnum"));

        int psCnt = projectService.projectSupportcnt(psvo);

        if (psCnt == 0) {
        String panum="";    //프로젝트 지원자 번호
        psvo.setPanum(panum);


        psvo.setRnum(req.getParameter("rnum"));
        psvo.setPnum(req.getParameter("pnum"));

        psvo.setMnum(req.getParameter("mnum"));
        psvo.setPaintro(req.getParameter("paintro")); // 프로젝트명
        System.out.println("한줄 소개 >>> : " + psvo.getPaintro());

        psvo.setPastartdate(req.getParameter("pastartdate")); //프로젝트 시작일
        System.out.println("프로젝트 시작가능일 >>> : " + psvo.getPastartdate());

        psvo.setPatypework(req.getParameter("patypework")); // 근무선택
        System.out.println("근무 형태 >>> : " + psvo.getPatypework());

        psvo.setPajob(req.getParameter("pajob"));   //직무선택
        System.out.println("직무 선택 >>> : " + psvo.getPajob());

        psvo.setPacarrer(req.getParameter("pacarrer")); //경력
        System.out.println("직무 선택 >>> : " + psvo.getPacarrer());

        psvo.setPaminpay(req.getParameter("paminpay")); //최소금액
        System.out.println("최소 급여 >> : " +  psvo.getPaminpay());

        psvo.setPamaxpay(req.getParameter("pamaxpay")); //최대금액
        System.out.println("최대 급여 >> : " +  psvo.getPamaxpay());


        psvo.setMpinfo(req.getParameter("mpinfo")); // 소개서
        System.out.println("소개서 >>> : " + psvo.getMpinfo());


        psvo.setMpfileup(req.getParameter("mpfileup"));


        psvo.setRname(req.getParameter("rname"));   //성명
        System.out.println("성명 >>> : " + psvo.getRname());

        psvo.setRengname(req.getParameter("rengname")); //영문
        System.out.println("영문 >>> : " + psvo.getRengname());

        psvo.setRbirth(req.getParameter("rbirth")); //생년월일
        System.out.println("생년월일 >>> : " + psvo.getRbirth());

        psvo.setRhp(req.getParameter("rhp")); //휴대폰
        System.out.println("휴대폰 >>> : " + psvo.getRhp());

        psvo.setRaddr(req.getParameter("raddr")); //주소
        System.out.println("주소 >>> : " + psvo.getRaddr());

        psvo.setRperiod(req.getParameter("rperiod")); //기간
        System.out.println("기간 >>> : " + psvo.getRperiod());

        psvo.setRschname(req.getParameter("rschname")); //학교명
        System.out.println("학교명 >>> : " + psvo.getRschname());

        psvo.setRmajor(req.getParameter("rmajor")); //학과
        System.out.println("학과 >>> : " + psvo.getRmajor());

        psvo.setRtenure(req.getParameter("rtenure"));   //근무 기간
        System.out.println("근무 기간 >>> : " + psvo.getRtenure());

        psvo.setRrespons(req.getParameter("rrespons")); //업무 내용
        System.out.println("업무 내용 >>> : " + psvo.getRrespons());

        psvo.setRworkname(req.getParameter("rworkname"));   //근무처
        System.out.println("근무처 >>> : " + psvo.getRworkname());

        psvo.setRacqui(req.getParameter("racqui")); //취득년월일
        System.out.println("취득년월일 >>> : " + psvo.getRacqui());

        psvo.setRlicense(req.getParameter("rlicense")); //자격증및 특기사항 내용
        System.out.println("자격증및 특기사항 내용 >>> : " + psvo.getRlicense());

        psvo.setRpublisher(req.getParameter("rpublisher")); //발령청
        System.out.println("발령청 >>> : " + psvo.getRpublisher());

        int nCnt = projectService.projectSupportInsert(psvo);

        avo.setAlsendmnum(req.getParameter("mnum"));
        avo.setAlreceivcnum(req.getParameter("cnum"));

        int anCnt = alarmService.alarmSupInsert(avo);


        System.out.print("nCnt >>>" + nCnt);
        return "project/projectSupportInsert";


        }else{
            return "project/projectSupportInsertErr";
        }


    }// end of projectSupportInsert


    /*프로젝트 신청자목록, 프로젝트 참여자 현황*/
    @RequestMapping("/projectManage")
    public String projectSupportSelectAll(ProjectSupportVO psvo, Model model, HttpServletRequest req){
        System.out.println("프로젝트 관리페이지로 이동");

        //프로젝트 번호 가져오기
        String pnum = req.getParameter("pnum");
        System.out.println("pnum <><>" + pnum);
        psvo.setPnum(pnum);
        model.addAttribute("pnum", pnum);
        String pname = req.getParameter("pname");
        model.addAttribute("pname", pname);

        // projectSupportPartSelectAll 쿼리 실행
        List<ProjectSupportVO> partListAll = projectService.projectSupportPartSelectAll(psvo);

        // projectSupportSelectAll 쿼리 실행
        List<ProjectSupportVO> listAll = projectService.projectSupportSelectAll(psvo);


        model.addAttribute("listAll", listAll);
        model.addAttribute("partListAll", partListAll);

        return "project/projectManage";


    }// end of projectSupportSelectAll




    /* 지원/이력서 열람 */
    @RequestMapping ("projectManageContents")
    public String projectSupportSelect(HttpServletRequest req, ProjectSupportVO psvo, Model model){


        psvo.setMnum(req.getParameter("mnum"));
        System.out.println("엠넘 >>>" + psvo.getMnum());

        List<ProjectSupportVO> listS = projectService.projectSupportSelect(psvo);

        System.out.println("리스트사이즈" +  listS.size());
        if(listS.size() == 1){

            model.addAttribute("listS", listS);
            return "project/projectManageContents";
        }

        return "project/projectManageContents";
    }// end of projectSupportSelect



    /* 프로젝트 신청자목록 거절 */
    @GetMapping(value="/projectManageDelete")
    public String projectManageDelete(Model model, ProjectSupportVO psvo, HttpServletRequest req){
        System.out.println("프로젝트 지원거절");
        psvo.setPanum(req.getParameter("panum"));
        String pnum = req.getParameter("pnum");
        System.out.println("pnum >> " + pnum);
        String pname = req.getParameter("pname");
        model.addAttribute("pname", pname);

        int aList = projectService.projectManageDelete(psvo);

        if(aList > 0){
            model.addAttribute("pnum", pnum);

            return "project/projectManageDelete";
        }
        return "project/projectManageDelete";
    }// end of projectManageDelete

}
