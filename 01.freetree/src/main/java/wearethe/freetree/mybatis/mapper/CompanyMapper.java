package wearethe.freetree.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;
import wearethe.freetree.company.vo.CompanyVO;

@Mapper
public interface CompanyMapper {

    int getCompanyInsert(CompanyVO cvo);
}
