package wearethe.freetree.account.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import wearethe.freetree.account.service.LoginService;
import wearethe.freetree.member.vo.MemberVO;
import wearethe.freetree.util.K_Session;
import wearethe.freetree.company.vo.CompanyVO;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/")
public class LoginController {

    private final LoginService loginService;

    public LoginController(LoginService loginService) {

        this.loginService = loginService;
    }

    @RequestMapping(value = "/loginform1")
    public String login(Model model) {
        System.out.println("로그인페이지로 이동");

        return "thymeleaf/account/loginpage";
    }

    @PostMapping("/comloginCheck")
    public String comLoginCheck(HttpServletRequest req, CompanyVO cvo, Model model) {
        // 값 확인하려고
        cvo.setCemail(req.getParameter("cemail"));
        System.out.println(cvo.getCemail());
        cvo.setCpw(req.getParameter("cpw"));
        System.out.println(cvo.getCpw());



        // 서비스 호출
        List<CompanyVO> comlistLogin = loginService.comLoginCheck(cvo);

        if (comlistLogin.size() == 1 ) {
            // 세션 확인
            String userId = comlistLogin.get(0).getCnum();
            K_Session ks = K_Session.getInstance();
            String kID = ks.getSession(req);

            System.out.println("comlistLogin.size() == 1 // true");
            // 찾아온게 null 이 아니면
            // list에 첫번째에 들어오는 거 찾기 (for로 돌려도 된다.)
            if(kID !=null && kID.equals(comlistLogin.get(0).getCnum())) {
                System.out.println("세션 이미 가지고있는데 로그인창 어케 들어옴? 개버그");

                model.addAttribute("comlistLogin", comlistLogin);
                System.out.println("comlistLogin >>>> : " + comlistLogin);
                return "common/main";
            // 성공 처리를 위한 로직 작성
            } else {
                /*CompanyVO _cvo = comlistLogin.get(0);
                System.out.println("Cnum: " + _cvo.getCnum());*/

                ks.setSession(req, userId);
                model.addAttribute("comlistLogin", comlistLogin);


                // 로그인 성공
                System.out.println("일치 성공해서 test페이지로가는 기업");
                return "common/main";
            }

        }


        return "thymeleaf/account/loginError";
    }


    @RequestMapping(value = "/logoutForm")
    public String logout(HttpServletRequest req) {
        System.out.println("로그아웃 폼 입장");
        // 세션 해제 (로그아웃)
        K_Session ks = K_Session.getInstance();

        ks.killSession(req);

        return "common/main"; // 로그아웃 시 이동할 페이지
    }

    @RequestMapping(value = "/faquestion")
    public String faquestion(Model model) {


        System.out.println("로그인페이지로 이동");

        return "/question/faquestion";
    }

    @PostMapping("/memloginCheck")
    public String memLoginCheck(HttpServletRequest req, MemberVO mvo, Model model) {

        // 값 확인하려고
        mvo.setMemail(req.getParameter("memail"));
        System.out.println(mvo.getMemail());
        mvo.setMpw(req.getParameter("mpw"));
        System.out.println(mvo.getMpw());

        // 서비스 호출
        List<MemberVO> memlistLogin = loginService.memLoginCheck(mvo);
        if (memlistLogin.size() == 1 ) {

            String userId = memlistLogin.get(0).getMnum();
            // 세션 확인
            K_Session ks = K_Session.getInstance();
            String kID = ks.getSession(req);
            System.out.println("memlistLogin.size() == 1 // true");


            // 찾아온게 null 이 아니면
            // list에 첫번째에 들어오는 거 찾기 (for로 돌려도 된다.)
            if(kID !=null && kID.equals(memlistLogin.get(0).getMnum())) {
                System.out.println("세션 이미 가지고있는데 로그인창 어케 들어옴? 개버그");


                model.addAttribute("memlistLogin", memlistLogin);
                System.out.println("memlistLogin >>>> : " + memlistLogin);

                return "common/main";
                // 성공 처리를 위한 로직 작성
            } else {

                ks.setSession(req, userId);

                model.addAttribute("memlistLogin", memlistLogin);

                // 로그인 성공
                System.out.println("일치 성공해서 test페이지로");
                return "common/main";
            }
        }

        return "thymeleaf/account/loginError";
    }


    // logincheck 엔드포인트 추가
    @GetMapping(value = "/logincheck", produces = "text/plain;charset=UTF-8")
    @ResponseBody
    public String logincheck(HttpServletRequest q, HttpSession session){
        String mnum = (String) session.getAttribute("mnum");
        if(mnum != null) {
            // 세션에 저장된 mnum 값이 존재할 경우, 해당 mnum 값을 반환
            return mnum;
        } else {
            // 세션에 저장된 mnum 값이 없을 경우 "loginx"를 반환
            return "loginx";
        }
    }

    @RequestMapping(value="/articles")
    public String articles(Model model) {
        System.out.println("서비스 이용약관");

        return "thymeleaf/account/articles";
    }

    @RequestMapping(value="/privacy")
    public String privacy(Model model) {
        System.out.println("개인정보의 수집 및 이용");

        return "thymeleaf/account/privacy";
    }

    @RequestMapping(value="/marketing")
    public String marketing(Model model) {
        System.out.println("마케팅 수집");

        return "thymeleaf/account/marketing";
    }

    @RequestMapping(value="/memInsertSuccess")
    public String memInsertSuccess(Model model) {
        System.out.println("회원가입 완료");

        return "memInsertSuccess.jsp";
    }

    @RequestMapping(value="/comInsertSuccess")
    public String comInsertSuccess(Model model) {
        System.out.println("회원가입 완료");

        return "thymeleaf/account/comInsertSuccess";
    }

}