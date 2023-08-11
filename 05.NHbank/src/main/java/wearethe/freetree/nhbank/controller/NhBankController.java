package wearethe.freetree.nhbank.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;
import wearethe.freetree.nhbank.service.NhBankService;
import wearethe.freetree.nhbank.vo.NhBankVO;

import java.util.ArrayList;
import java.util.HashMap;


@Controller
    @RequestMapping("/")
        public class NhBankController {
        private final NhBankService nhbankService;

        public NhBankController(NhBankService nhbankService) {
            this.nhbankService = nhbankService;
        }
    //===========================================================================
    //2. 가상계좌 입금내역 조회(가상계좌 -> 모계좌)
        @RequestMapping(value="/nh_deposit")
        public String nh_aaaa_1(Model model){
            System.out.println("TestNHController.nh_aaaa_1 함수 진입 성공 >>> : ");

            return "nhbank/depositdetails";
        }

        //농협 API 가상계좌 입금내역 조회 depositdetails
        @RequestMapping(value="/depositdetails")
        @ResponseBody
        public String depositdetails(@RequestBody HashMap<String, Object> map, Model model){
            System.out.println("depositdetails 함수 진입 성공 >>> : " + map);
            String vrans = "";
            String mnrcdt = "";
            String mntmd = "";
            String mnrcAmt = "";

            System.out.println(">>>>>>>>>>>>>>> : " + map.get("REC"));
            ArrayList al = (ArrayList)map.get("REC");
            System.out.println(">>>>>>>>>>>>>>> : al :::: " + al);

            ArrayList aList = new ArrayList();
            for(int i = 0; i < al.size(); i++) {

                HashMap aa = (HashMap) al.get(i);
                vrans = (String) aa.get("Vran");
                mnrcdt = (String) aa.get("MnrcDt");
                mntmd = (String) aa.get("Mntmd");
                mnrcAmt = (String) aa.get("MnrcAmt");
                String year = mnrcdt.substring(0, 4);
                String month = mnrcdt.substring(4, 6);
                String day = mnrcdt.substring(6, 8);
                String hour = mntmd.substring(0, 2);
                String minute = mntmd.substring(2, 4);
                String second = mntmd.substring(4, 6);

                // "HH:MM:SS" 형식으로 합치기
                String formattedTime = hour + ":" + minute + ":" + second;
                System.out.println("Formatted Time: " + formattedTime);
                String formattedDate = year + "-" + month + "-" + day;
                System.out.println("Formatted Date: " + formattedDate);
                System.out.println(vrans + ", "
                        + formattedDate + ", "
                        + formattedTime + ", "
                        + mnrcAmt);
                String datehms = formattedDate + " " + formattedTime;
                NhBankVO nhvo = new NhBankVO();
                nhvo.setVrans(vrans);
                nhvo.setMnrcdt(datehms);
                nhvo.setMnrcAmt(mnrcAmt);
                NhBankVO _nhvo = nhbankService.nhDBCount();
                String tempnum = _nhvo.getNhnum();
                nhvo.setNhnum(tempnum);

                aList.add(nhvo);
                nhbankService.depositInsert(nhvo);
            }
            //return  변경하기
            return "index";
        }

    //======================================================dddddddddddd=====================
    //3. 결제대금 지급계좌 이체요청
      @RequestMapping(value="/accounttransfer")
      @ResponseBody
      public String accounttransfer(@RequestBody HashMap<String, Object> map,Model model){
              System.out.println(">>농협 API 결제대금 지급계좌 이체요청>>>>>>>>");
              String rgno = (String) map.get("Rgno");
              String tram = (String) map.get("Tram");

              NhBankVO nhvo = new NhBankVO();
              nhvo.setRgno(rgno);
              nhvo.setTram(tram);
              NhBankVO _nhvo = nhbankService.nhDBCount1();
              String tempnum = _nhvo.getNhnum1();
              nhvo.setNhnum1(tempnum);

              nhbankService.accountInsert(nhvo);

              return "index";

        }
        @RequestMapping(value="/accounttrans")
        public String accounttrans(Model model){
            System.out.println("TestNHController.accounttrans 함수 진입 성공 >>> : ");
            return "nhbank/accounttransfer";
        }

    //===========================================================================
    //4. 결제대금 지급요청
    @RequestMapping(value="/receivedtransfer")
    public String receivedtransfer(Model model){
        System.out.println(">>농협 API 결제대금 지급계좌 이체요청>>>>>>>>");
        return "index";
    }
    @RequestMapping(value="/received")
    public String received(Model model){
        System.out.println("TestNHController.accounttrans 함수 진입 성공 >>> : ");
        return "nhbank/receivedtransfer";
    }

//===========================================================================
    //5. 거래 내역 조회(모계좌의 출금)
    @RequestMapping(value="/transaction")
    @ResponseBody
    public String transaction(@RequestBody HashMap<String, Object> map, Model model){
        System.out.println("transaction 함수 진입 성공 >>> : " + map);
        return "index";
    }
    @RequestMapping(value="/trans")
    public String trans(Model model){
        System.out.println("TestNHController.trans 함수 진입 성공 >>> : ");

        return "nhbank/transaction";
    }

}
/*    //농협 API 결제대금 지급요청 결과확인checkreceivedtransfer
        @RequestMapping(value="/checkreceivedtransfer")
        public String checkreceivedtransfer(Model model){

            System.out.println(">>>/농협 API 결제대금 지급요청 결과확인>>>>>>>>");
            return "thymeleaf/nhbank/checkreceivedtransfer";
        }*/

//농협 API 결제대금 지급계좌 이체요청accounttransfer
  /*      @RequestMapping(value="/accounttransfer")
        public String accounttransfer(Model model){
            System.out.println(">>농협 API 결제대금 지급계좌 이체요청>>>>>>>>");
            return "thymeleaf/nhbank/accounttransfer";
        }*/
       /* //농협 API 결제대금 지급계좌 이체요청 결과확인checkaccounttransfer
        @RequestMapping(value="/checkaccounttransfer")
        public String checkaccounttransfer(Model model){

            System.out.println(">>>>농협 API 결제대금 지급계좌 이체요청 결과확인>>>>>>>");
            return "thymeleaf/nhbank/checkaccounttransfer";
        }*//* //농협 API >결제대금 지급요청receivedtransfer
        @RequestMapping(value="/receivedtransfer")
        public String receivedtransfer(Model model){

            System.out.println(">>>>>농협 API >결제대금 지급요청>>>>>>");
            return "thymeleaf/nhbank/receivedtransfer";
        }*/
  /*  @RequestMapping(value="/depositdetails")
    @ResponseBody
    public String depositdetails(@RequestBody HashMap<String, Object> map, Model model){
        System.out.println("depositdetails 함수 진입 성공 >>> : " + map);

        String vrans = "";
        String sqno = "";
        String mnrcstts = "";
        String mnrcdt = "";
        String mntmd = "";
        String mnChkTm = "";
        String mnrcAmt = "";

        System.out.println(">>>>>>>>>>>>>>> : " + map.get("REC"));
        ArrayList al = (ArrayList)map.get("REC");
        System.out.println(">>>>>>>>>>>>>>> : al :::: " + al);

        ArrayList aList = new ArrayList();
        for(int i = 0; i < al.size(); i++) {

            HashMap aa = (HashMap)al.get(i);
            vrans = (String)aa.get("Vran");
            sqno = (String)aa.get("Sqno");
            mnrcstts = (String)aa.get("MnrcStts");
            mnrcdt = (String)aa.get("MnrcDt");
            mntmd = (String)aa.get("Mntmd");
            mnChkTm = (String)aa.get("MnChkTm");
            mnrcAmt = (String)aa.get("MnrcAmt");

            System.out.println(   vrans + ", "
                    + sqno + ", "
                    + mnrcstts + ", "
                    + mnrcdt + ", "
                    + mntmd + ", "
                    + mnChkTm + ", "
                    + mnrcAmt);

            NhBankVO nhvo = new NhBankVO();
            nhvo.setVrans(vrans);
            nhvo.setSqno(sqno);
            nhvo.setMnrcstts(mnrcstts);
            nhvo.setMnrcdt(mnrcdt);
            nhvo.setMntmd(mntmd);
            nhvo.setMnChkTm(mnChkTm);
            nhvo.setMnrcAmt(mnrcAmt);
            NhBankVO _nhvo = nhbankService.nhDBCount();
            String tempnum = _nhvo.getNhnum();
            nhvo.setNhnum(tempnum);

            aList.add(nhvo);
            nhbankService.depositInsert(nhvo);

        }
        //return  변경하기
        return "index";
    }
*/