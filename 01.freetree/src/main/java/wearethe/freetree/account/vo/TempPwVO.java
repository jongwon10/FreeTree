package wearethe.freetree.account.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class TempPwVO {
    private String mnum;
    private String memail;
    private String cnum;
    private String cemail;
    private String pnum;
    private String ppw;
}
