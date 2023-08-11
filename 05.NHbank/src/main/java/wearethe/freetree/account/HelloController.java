package wearethe.freetree.account;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class HelloController {

    @GetMapping("/okok")
    public String hello() {
        System.out.println("ㅇㅋ;");
        return "okok";
    }
}