package test;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {


    @RequestMapping("/test")
    public String test() {

        return "abc";
    }




    @RequestMapping("/test_1")
    public String test_1(Model model) throws Exception {

        model.addAttribute("greeting", "Hello Thymeleaf!");

        return "thymeleaf/welcome";
    }
}
