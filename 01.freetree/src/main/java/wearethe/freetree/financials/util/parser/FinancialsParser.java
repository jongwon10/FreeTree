package wearethe.freetree.financials.util.parser;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import lombok.Data;

@Data
public class FinancialsParser {
    private String orderId;
    private String orderName;
    private String totalAmount;
    private String status;
    private String approvedAt;
    private String paymentKey;
    private String checkoutUrl;

    public FinancialsParser(JsonObject jsonObject) {
        parseJson(jsonObject);
        System.out.println("<< FinancialsParser >>");
    }

    private void parseJson(JsonObject jsonObject) {
        // 파서
        orderId = jsonObject.get("orderId").getAsString();
        orderName = jsonObject.get("orderName").getAsString();
        totalAmount = jsonObject.get("totalAmount").getAsString();
        status = jsonObject.get("status").getAsString();
        approvedAt = jsonObject.get("approvedAt").getAsString();
        paymentKey = jsonObject.get("paymentKey").getAsString();
        checkoutUrl = jsonObject.getAsJsonObject("receipt").get("url").getAsString();

        // 로그
        System.out.println("Parsed values:");
        System.out.println("orderId: " + orderId);
        System.out.println("orderName: " + orderName);
        System.out.println("totalAmount: " + totalAmount);
        System.out.println("status: " + status);
        System.out.println("approvedAt: " + approvedAt);
        System.out.println("paymentKey: " + paymentKey);
        System.out.println("checkoutUrl: " + checkoutUrl);
    }
}