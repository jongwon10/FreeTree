package wearethe.freetree.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SignatureMapper {

    void saveSignature(byte[] signatureImage);
}