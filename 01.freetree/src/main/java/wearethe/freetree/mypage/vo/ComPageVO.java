package wearethe.freetree.mypage.vo;
import org.springframework.web.multipart.MultipartFile;
import lombok.*;
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ComPageVO {
   private String cprofileimg;
   private String cnum;
   private String cname;
   private String cpostalcode;
   private String croadaddr;
   private String caddr;
   private String croaddetail;
   private String cpinfo;
   private String cinfo;
   private String cpinfoimg;
   private String cbackimg;
   private String cpfileupload;
   private String cpage;
   private String cemail; // 아이디(이메일)
   private String cpw; // 비밀번호
   private String chp; // 담당자 휴대폰
   private String ctel; // 기업 전화번호
   private String ccomtype; // 기업형태
   private String cbiznum; // 사업자 등록 번호
   private String cinfodate; // 개인정보 유효기간
   private String cterms; // 약관 동의 여부
   private String cregister; // 가입일
   private String cleave; // 탈퇴 여부
   private String cappro; // 가입승인여부
   private String cpersonnel; // 담당자명
   private String cdelegate; // 대표자명
   private String cinfoimg;
   private String pnum;
   private String pname;
}
