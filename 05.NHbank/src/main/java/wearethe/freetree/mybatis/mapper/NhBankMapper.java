package wearethe.freetree.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;
import wearethe.freetree.nhbank.vo.NhBankVO;


@Mapper
public interface NhBankMapper {
    int depositInsert(NhBankVO nhvo);
    int accountInsert(NhBankVO nhvo);
    NhBankVO nhDBCount();
    NhBankVO nhDBCount1();
}