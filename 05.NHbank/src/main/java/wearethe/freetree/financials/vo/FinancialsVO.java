package wearethe.freetree.financials.vo;

import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FinancialsVO {

    private String tosspnum;
    private String orderId;
    private String orderName;
    private String totalAmount;
    private String status;
    private String approvedAt;
    private String paymentKey;
    private String json;

}
