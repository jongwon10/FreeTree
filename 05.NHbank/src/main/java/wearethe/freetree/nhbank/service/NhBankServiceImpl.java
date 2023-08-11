package wearethe.freetree.nhbank.service;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wearethe.freetree.mybatis.mapper.NhBankMapper;
import wearethe.freetree.nhbank.vo.NhBankVO;

import java.util.Map;

@Service
public class NhBankServiceImpl implements NhBankService {

    private final NhBankMapper nhbankMapper;
    private JSONObject responseData;

    //쿼리 매핑
    @Autowired
    public NhBankServiceImpl(NhBankMapper nhbankMapper) {this.nhbankMapper = nhbankMapper;}

    // insert 쿼리문
    @Override
    public int depositInsert(NhBankVO nhvo) {
        return nhbankMapper.depositInsert(nhvo);
    }

    @Override
    public int accountInsert(NhBankVO nhvo) {
        return nhbankMapper.accountInsert(nhvo);
    }

    //채번 쿼리
    @Override
    public NhBankVO nhDBCount() {
        return nhbankMapper.nhDBCount();
    }

    @Override
    public NhBankVO nhDBCount1() {

            return nhbankMapper.nhDBCount1();}

    //JSON 처리
    @Override
    public JSONObject getResponseData() {
        return responseData;
    }
}
