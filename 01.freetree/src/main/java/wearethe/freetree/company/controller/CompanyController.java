package wearethe.freetree.company.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import wearethe.freetree.company.service.CompanyService;
import wearethe.freetree.company.vo.CompanyVO;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping(value = "/")
public class CompanyController {

    private final CompanyService companyService;

    @Autowired
    public CompanyController(CompanyService companyService) {
        this.companyService = companyService;
    }

    @RequestMapping(value = "/caccount")
    public String companyInsertForm() {
        System.out.println("회원가입");

        return "thymeleaf/account/account";
    }

    @RequestMapping(value = "/com")
    public String companyInsert(HttpServletRequest req, CompanyVO cvo) {
        System.out.println("기업 회원가입");

        cvo.setCnum(""); // 채번 회원번호
        cvo.setCemail(req.getParameter("cemail")); // 이메일(아이디)
        cvo.setCpw(req.getParameter("cpw")); // 비밀번호
        cvo.setChp(req.getParameter("chp")); // 담당자 전화번호
        cvo.setCtel(req.getParameter("ctel")); // 기업 전화번호
        cvo.setCcomtype(req.getParameter("ccomtype")); // 기업 형태
        cvo.setCbiznum(req.getParameter("cbiznum")); // 사업자 등록 번호
        cvo.setCname(req.getParameter("cname")); // 기업명
        cvo.setCpostalcode(req.getParameter("cpostalcode")); // 기업 우편번호
        cvo.setCroadaddr(req.getParameter("croadaddr")); // 기업 도로명 주소
        cvo.setCaddr(req.getParameter("caddr")); // 기업 주소
        cvo.setCroaddetail(req.getParameter("croaddetail")); //기업 상세주소
        cvo.setCinfodate("cinfodate"); // 개인정보 유효기간
        cvo.setCterms("cterms"); // 약관 동의 여부
        cvo.setCregister(""); // 가입일
        cvo.setCleave(""); // 탈퇴 여부
        cvo.setCappro(""); // 가입승인여부
        cvo.setCpersonnel(req.getParameter("cpersonnel")); // 담당자명
        cvo.setCdelegate(req.getParameter("cdelegate")); // 대표자명

        int nCnt = companyService.getCompanyInsert(cvo);

        if (nCnt > 0) {
            return "thymeleaf/account/comInsertSuccess";
        }

        return "thymeleaf/account/account";
    }
}
