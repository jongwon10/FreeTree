package wearethe.freetree.account.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wearethe.freetree.company.vo.CompanyVO;
import wearethe.freetree.member.vo.MemberVO;
import wearethe.freetree.mybatis.mapper.LoginMapper;

import java.util.List;

@Service
public class LoginServiceImpl implements LoginService {

    private final LoginMapper loginMapper;

    @Autowired
    public LoginServiceImpl(LoginMapper loginMapper) {
        this.loginMapper = loginMapper;}

    @Override
    public List<CompanyVO> comLoginCheck(CompanyVO cvo) {

        return loginMapper.comLoginCheck(cvo);
    }

    @Override
    public List<MemberVO> memLoginCheck(MemberVO mvo) {

        return loginMapper.memLoginCheck(mvo);
    }

}
