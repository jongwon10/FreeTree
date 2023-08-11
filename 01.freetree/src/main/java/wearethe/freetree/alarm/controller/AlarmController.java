package wearethe.freetree.alarm.controller;


import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import wearethe.freetree.alarm.service.AlarmService;
import wearethe.freetree.alarm.vo.AlarmVO;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/")
public class AlarmController {

    private final AlarmService alarmService;

    public AlarmController(AlarmService alarmService) {this.alarmService = alarmService;}

    @RequestMapping(value="/alarm")
    public String alarmSelectAll(HttpServletRequest req, AlarmVO avo, Model model){

       String id = req.getParameter("mnum");
       System.out.println("id >>> "+ id);

       if (id.equals("null")) {
           avo.setAlreceivcnum(req.getParameter("cnum"));
           System.out.println("id >>>> " +avo.getAlreceivcnum());
           List<AlarmVO> list = alarmService.alarmReceivec(avo);

           int nCnt = list.size();
           if (nCnt > 0) {
               model.addAttribute("list", list);
               return "alarm/alarmPage";
           }


       }else {
           avo.setAlreceivmnum(id);
           List<AlarmVO> list = alarmService.alarmReceivem(avo);

           int nCnt = list.size();
           if (nCnt > 0) {
               model.addAttribute("list", list);
               return "alarm/alarmPage";
           }
       }

        return "alarm/alarmPage";
    }

    @RequestMapping(value="/deletealarm")
    public String deletealarm(HttpServletRequest req, AlarmVO avo) {

        avo.setAlnum(req.getParameter("alnum"));

        System.out.println("alnum" + avo.getAlnum());

        int nCnt = alarmService.deleteAlarm(avo);
        System.out.println("nCnt >>> " + nCnt);
        if (nCnt > 0) {
            return "alarm/alarmPage";
        }

        return "alarm/alarmPage";
    }
}
