package wearethe.freetree.mybatis.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import wearethe.freetree.financials.vo.FinancialsVO;

@Mapper
public interface FinancialsMapper {

    int tosspayapiInsert(FinancialsVO financialsVO);
    FinancialsVO tosspayapiDBCount();

}