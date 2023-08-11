package wearethe.freetree.member.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import wearethe.freetree.member.service.MemberService;
import wearethe.freetree.member.vo.MemberVO;

import java.util.List;

@Controller
@RequestMapping(value="/")
public class MemberController {

    private final MemberService memberService;

    @Autowired
    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }

    @RequestMapping(value="/home")
    public String home(Model model) {
        System.out.println("홈화면");

        System.out.println("서비스 진입 시작");
        List<MemberVO> memberList = memberService.getAllMember();

        if (!memberList.isEmpty()) {
            MemberVO firstMember = memberList.get(0);

            // firstMember를 사용하여 추가적인 작업 수행
            String num = firstMember.getNum();
            String id = firstMember.getId();
            String pw = firstMember.getPw();
            String name = firstMember.getName();

            // 예: 출력하기
            System.out.println("첫 번째 회원번호: " + num);
            System.out.println("첫 번째 아이디: " + id);
            System.out.println("첫 번째 비밀번호: " + pw);
            System.out.println("첫 번째 이름: " + name);
        }

        // memberList를 모델에 추가하여 뷰로 전달
        model.addAttribute("memberList", memberList);

        return "thymeleaf/member/home";
    }


}