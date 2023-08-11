package wearethe.freetree.financials.service;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wearethe.freetree.financials.vo.FinancialsVO;
import wearethe.freetree.mybatis.mapper.FinancialsMapper;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.List;

@Service
public class FinancialsServiceImpl implements FinancialsService {

    private final FinancialsMapper financialsMapper;

    @Autowired      // 쿼리 맵핑
    public FinancialsServiceImpl(FinancialsMapper financialsMapper) {
        this.financialsMapper = financialsMapper;
    }
    private JSONObject responseData;

    @Override       //토스 결제 api
    public boolean callPaymentAPI(String orderId, String paymentKey, String amount) {
        try {
            String secretKey = "test_sk_mnRQoOaPz8L1wE6bOWP3y47BMw6v:";

            Base64.Encoder encoder = Base64.getEncoder();
            byte[] encodedBytes = encoder.encode(secretKey.getBytes("UTF-8"));
            String authorizations = "Basic " + new String(encodedBytes, 0, encodedBytes.length);

            paymentKey = URLEncoder.encode(paymentKey, StandardCharsets.UTF_8);

            URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");

            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestProperty("Authorization", authorizations);
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestMethod("POST");
            connection.setDoOutput(true);
            JSONObject obj = new JSONObject();
            obj.put("paymentKey", paymentKey);
            obj.put("orderId", orderId);
            obj.put("amount", amount);

            OutputStream outputStream = connection.getOutputStream();
            outputStream.write(obj.toString().getBytes(StandardCharsets.UTF_8));

            int code = connection.getResponseCode();
            boolean isSuccess = code == 200;

            InputStream responseStream = isSuccess ? connection.getInputStream() : connection.getErrorStream();

            Reader reader = new InputStreamReader(responseStream, StandardCharsets.UTF_8);
            JSONParser parser = new JSONParser();
            responseData = (JSONObject) parser.parse(reader);
            System.out.println("출력api rsData : "+responseData);
            System.out.println("isSuccess : " + isSuccess);
            responseStream.close();

            return isSuccess;
        } catch (IOException | ParseException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override // insert 쿼리문
    public int tosspayapiInsert(FinancialsVO financialsVO) {

        return financialsMapper.tosspayapiInsert(financialsVO);
    }

    @Override // 채번 쿼리문
    public FinancialsVO tosspayapiDBCount() {
        return financialsMapper.tosspayapiDBCount();
    }

    @Override       // JSON 처리
    public JSONObject getResponseData() {
        return responseData;
    }
}