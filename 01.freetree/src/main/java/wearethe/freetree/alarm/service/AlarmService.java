package wearethe.freetree.alarm.service;

import wearethe.freetree.alarm.vo.AlarmVO;

import java.util.List;

public interface AlarmService {

    List<AlarmVO> alarmReceivem(AlarmVO avo);

    List<AlarmVO> alarmReceivec(AlarmVO avo);

    int deleteAlarm(AlarmVO avo);

    int alarmSupInsert(AlarmVO avo);
}
