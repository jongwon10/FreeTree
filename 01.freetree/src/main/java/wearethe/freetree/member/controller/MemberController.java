package wearethe.freetree.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import wearethe.freetree.member.service.MemberService;
import wearethe.freetree.member.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value="/")
public class MemberController {

    private final MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @RequestMapping(value="/maccount")
    public String memberInsertForm() {
        System.out.println("회원가입");

        return "thymeleaf/account/account";
    }

    // 입력
    @RequestMapping(value="/mem")
    public String memberInsert(HttpServletRequest req, MemberVO mvo, Model model) {
        System.out.println("회원가입");


        mvo.setMnum(""); // 채번 회원번호
        mvo.setMemail(req.getParameter("memail")); // 이메일(아이디)
        mvo.setMpw(req.getParameter("mpw")); // 비밀번호
        mvo.setMname(req.getParameter("mname")); // 이름
        mvo.setMhp(req.getParameter("mhp")); // 핸드폰
        mvo.setMbirth(req.getParameter("mbirth")); // 출생년도
        mvo.setMgender(req.getParameter("mgender")); // 성별
        mvo.setMnick(req.getParameter("mnick")); // 닉네임
        mvo.setMinfodate("minfodate"); // 개인정보 유효기간
        mvo.setMsns("msns"); // SNS 수신 동의여부
        mvo.setMterms("mterms"); // 약관 동의여부
        mvo.setMregister(""); // 가입일
        mvo.setMleave(""); // 탈퇴여부
        mvo.setMphoto(""); // 사진
        mvo.setMresume(""); // 이력서
        mvo.setMresumemain(""); // 대표 이력서

        System.out.println("이메일" + mvo.getMemail());

        int nCnt = memberService.getMemberInsert(mvo);

        String memail = req.getParameter("memail");
        if (nCnt > 0) {
            model.addAttribute("memail", memail);
            return "account/memInsertSuccess";
        }


        return "thymeleaf/account/account";
    }
}