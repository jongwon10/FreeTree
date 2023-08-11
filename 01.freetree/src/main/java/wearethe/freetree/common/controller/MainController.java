package wearethe.freetree.common.controller;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import wearethe.freetree.common.service.MainService;

@Controller
@RequestMapping("/")
public class MainController {

    private final MainService mainService;

    public MainController(MainService mainService) {
        this.mainService = mainService;
    }

    @RequestMapping(value="/header")
    public String header(Model model) {
        System.out.println("헤더 불러옴");

        return "common/header";
    }

    @RequestMapping(value="/main")
    public String main(Model model) {
        System.out.println("메인 들어옴");

        return "common/main";
    }

    @RequestMapping(value="/footer")
    public String footer(Model model) {
        System.out.println("푸터 불러옴");

        return "thymeleaf/common/footer";
    }

    @RequestMapping(value="/chat")
    public String chat(Model model) {
        System.out.println("푸터 불러옴");

        return "thymeleaf/common/chat";
    }



}
