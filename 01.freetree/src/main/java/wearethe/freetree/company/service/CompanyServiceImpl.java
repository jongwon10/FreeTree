package wearethe.freetree.company.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wearethe.freetree.company.vo.CompanyVO;
import wearethe.freetree.mybatis.mapper.CompanyMapper;

@Service
public class CompanyServiceImpl implements CompanyService{

    CompanyMapper companyMapper;

    @Autowired
    CompanyServiceImpl(CompanyMapper companyMapper) {
        this.companyMapper = companyMapper;
    }

    @Override
    public int getCompanyInsert(CompanyVO cvo) {
        System.out.println("getCompanyInsert 함수 진입 >>> ");

        return companyMapper.getCompanyInsert(cvo);
    }
}
