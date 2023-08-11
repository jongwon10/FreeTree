package wearethe.freetree.alarm.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AlarmVO {
    String alnum; // 알림 고유 아이디
    String alreceiving; // 수신 확인 'Y', 'N'
    String alsend; // 발신시간
    String alsendmnum; // 발신자
    String alsendcnum; // 발신자
    String alreceivmnum; // 수신자
    String alreceivcnum; // 수신자
    String alcontent; // 내용

    String cname;
    String mname;
}
