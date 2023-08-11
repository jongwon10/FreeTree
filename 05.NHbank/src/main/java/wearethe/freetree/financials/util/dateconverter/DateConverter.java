package wearethe.freetree.financials.util.dateconverter;

import com.google.gson.JsonObject;
import lombok.Data;

@Data
public class DateConverter {
    private String date;

    public DateConverter(String date) {
        System.out.println("<< DateConverter >>");
        gmtToDatetime(date);
    }

    // gmt -> datetime 변환
    private void gmtToDatetime(String date) {
        String cnDate[] = new String[2];
        String cnDate2[] = new String[2];
        StringBuilder result = new StringBuilder();

        cnDate = date.split("T");
        cnDate2 = cnDate[1].split("\\+");

        result.append(cnDate[0]);
        result.append(" ");
        result.append(cnDate2[0]);

        System.out.println("결과 : " + result.toString());

        setDate(result.toString());
    }
}
