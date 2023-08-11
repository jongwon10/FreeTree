package wearethe.freetree.financials.controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import wearethe.freetree.financials.service.FinancialsService;
import wearethe.freetree.financials.util.parser.FinancialsParser;
import wearethe.freetree.financials.util.dateconverter.DateConverter;
import wearethe.freetree.financials.vo.FinancialsVO;

@Controller
@RequestMapping("/")
public class FinancialsController {

    private final FinancialsService financialsService;

    @Autowired
    public FinancialsController(FinancialsService financialsService) {
        this.financialsService = financialsService;
    }

    // 토스 페이먼트 수수료결제 진입
    @RequestMapping(value="/ftossWidgetMain")
    public String ftossWidgetMain(Model model,
                                  @RequestParam(value="cnum", required=false) String cnum,
                                  @RequestParam(value="pnum", required=false) String pnum) {
        System.out.println("<< /ftossWidgetMain >>");
        System.out.println("cnum : " + cnum);
        System.out.println("pnum : " + pnum);

        // 모델에 필요한 데이터 추가
        model.addAttribute("cnum", cnum); // cnum
        model.addAttribute("pnum", pnum); // pnum

        return "thymeleaf/financials/ftossWidgetMain";
    }

    // 토스 페이먼트 결제 진행페이지 진입
    @RequestMapping(value="/ftosswidgetcheck")
    public String ftossWidgetCheck(
            @RequestParam("orderId") String orderId,
            @RequestParam("paymentKey") String paymentKey,
            @RequestParam("amount") String amount,
            @RequestParam("cnum") String cnum,
            @RequestParam("pnum") String pnum,
            Model model
    ) {

        boolean isSuccess = financialsService.callPaymentAPI(orderId, paymentKey, amount);
        JSONObject jsonObject = financialsService.getResponseData();

        // cnum
        model.addAttribute("cnum", cnum);
        model.addAttribute("pnum", pnum);
        model.addAttribute("isSuccess", isSuccess);
        System.out.println("controller >> isSuccess : " + isSuccess);
        model.addAttribute("jsonObject", jsonObject);
        System.out.println("controller >> jsonObject : " + jsonObject);
        System.out.println("결제성공");

        return "thymeleaf/financials/ftossWidgetCheck"; // 실제 Thymeleaf 템플릿의 이름으로 대체하세요
    }

    // 토스 페이먼트 결제 완료시 result <-> DB Insert
    @RequestMapping(value="/ftossinsert")
    public String ftossInsert(Model model,
                              @RequestParam("cnum") String cnum,
                              @RequestParam("pnum") String pnum) {

        // JSON -> 문자열 -> Json
        JSONObject jsonObject = financialsService.getResponseData();
        String jsonString = jsonObject.toString();

        JsonObject jsonObjectg = JsonParser.parseString(jsonString).getAsJsonObject();
        FinancialsParser financialsParser = new FinancialsParser(jsonObjectg);

        System.out.println("인서트 cnum : " + cnum);
        System.out.println("인서트 pnum : " + pnum);

        // 파서
        String orderId = financialsParser.getOrderId();
        String orderName = financialsParser.getOrderName();
        String totalAmount = financialsParser.getTotalAmount();
        String status = financialsParser.getStatus();
        String approvedAt = financialsParser.getApprovedAt();
        String paymentKey = financialsParser.getPaymentKey();

        // 채번
        FinancialsVO _financialsVO = financialsService.tosspayapiDBCount();
        String tempnum = _financialsVO.getTosspnum();

        // Date 컨버터 (gmt -> datetime)
        DateConverter dateConverter = new DateConverter(approvedAt);
        approvedAt = dateConverter.getDate();

        // 로그
        System.out.println("orderId : " + orderId);
        System.out.println("orderName : " + orderName);
        System.out.println("totalAmount : " + totalAmount);
        System.out.println("status : " + status);
        System.out.println("approvedAt : " + approvedAt);
        System.out.println("paymentKey : " + paymentKey);
        System.out.println("json : " + jsonString);
        System.out.println("tosspnum : " + tempnum);

        // VO Setting
        FinancialsVO financialsVO = new FinancialsVO();
        financialsVO.setOrderId(orderId);
        financialsVO.setOrderName(orderName);
        financialsVO.setTotalAmount(totalAmount);
        financialsVO.setStatus(status);
        financialsVO.setApprovedAt(approvedAt);
        financialsVO.setPaymentKey(paymentKey);
        financialsVO.setJson(jsonString);
        financialsVO.setTosspnum(tempnum);
        financialsVO.setPnum(pnum);

        financialsService.tosspayapiInsert(financialsVO);
        return "thymeleaf/financials/ftossInsert";
    }
    @RequestMapping(value="/ftosswidgetfail")
    public String payresultfail(Model model) {

        System.out.println("결제실패");
        return "thymeleaf/financials/ftossWidgetFail";
    }

}