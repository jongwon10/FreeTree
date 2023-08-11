package wearethe.freetree.push;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
@RequestMapping("/")
public class PushController {


    // 토스 페이먼트 수수료결제 진입
    @RequestMapping(value="/push")
    public String push(Model model, @RequestParam(value="pushfilter", required=false) String pushfilter) {
        System.out.println("<< /push >>");
        System.out.println("pushfilter: " + pushfilter);
        // 모델에 필요한 데이터 추가
        model.addAttribute("pushfilter", pushfilter); // pushfilter
        return "tokkentest";
    }

    @RequestMapping(value="/popup")
    public String pop(){

        return "popup";
    }
}