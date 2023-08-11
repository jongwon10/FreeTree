package wearethe.freetree.mybatis.mapper;

import org.apache.ibatis.annotations.Mapper;
import wearethe.freetree.alarm.vo.AlarmVO;

import java.util.List;

@Mapper
public interface AlarmMapper {

    List<AlarmVO> alarmReceivem(AlarmVO avo);

    List<AlarmVO> alarmReceivec(AlarmVO avo);

    int deleteAlarm(AlarmVO avo);

    int alarmSupInsert(AlarmVO avo);

}
