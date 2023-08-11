package wearethe.freetree.common;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.List;

public class FileUpload {
    private String imgfilePaths;
    private int imgfileSize;
    private String encodeType;
    public FileUpload(String imgfilePaths, int imgfileSize, String encodeType) {
        this.imgfilePaths = imgfilePaths;
        this.imgfileSize = imgfileSize;
        this.encodeType = encodeType;
    }

    public boolean imgfileUpload(HttpServletRequest req) {
        boolean bool = imgfileUpload(req, imgfilePaths);
        return bool;
    }
    public boolean imgfileUpload(HttpServletRequest req, String filePath) {
        boolean bool = false;
        try {
            MultipartResolver resolver = new CommonsMultipartResolver(req.getSession().getServletContext());
            List<MultipartFile> files = resolver.resolveMultipart(req).getFiles("imgfile");

            for (MultipartFile file : files) {
                file.transferTo(new File(filePath + File.separator + file.getOriginalFilename()));
            }

            bool = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return bool;
    }

    public String getParameter(String paramName, HttpServletRequest req) {
        return req.getParameter(paramName);
    }
    public String[] getParameterValues(String s) {

        return null; // MultipartResolver를 사용하여 직접 파라미터 값을 가져오지 않음
    }

    public static String getFileNames(ArrayList<MultipartFile> files, String path) {

      //  MultipartResolver resolver = new CommonsMultipartResolver(req.getSession().getServletContext());
    //    List<MultipartFile> files = resolver.resolveMultipart(req).getFiles("imgfile");
        String fileNames = "";

        ArrayList<String> FileNameList = new ArrayList<String>();
        for(MultipartFile file : files) {
            String FileName = file.getOriginalFilename();
            fileNames += FileName;
            FileNameList.add(FileName);
            // 5. 파일 생성
            File file1 = new File(path + "//" + FileName);
            // 6. 서버로 전송
            try {
                file.transferTo(file1);
            } catch (Exception e) {
            }
        }
        return fileNames;
    }
}
