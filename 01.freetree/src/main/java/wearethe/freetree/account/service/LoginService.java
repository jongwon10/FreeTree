package wearethe.freetree.account.service;

import wearethe.freetree.company.vo.CompanyVO;
import wearethe.freetree.member.vo.MemberVO;

import java.util.List;

public interface LoginService {

    List<CompanyVO> comLoginCheck(CompanyVO cvo);

    List<MemberVO> memLoginCheck(MemberVO mvo);

}
