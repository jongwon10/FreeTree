package wearethe.freetree.alarm.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import wearethe.freetree.alarm.vo.AlarmVO;
import wearethe.freetree.mybatis.mapper.AlarmMapper;

import java.util.List;

@Service
public class AlarmServiceImpl implements   AlarmService {

    AlarmMapper alarmMapper;

    @Autowired
    public AlarmServiceImpl(AlarmMapper alarmMapper)
    {this.alarmMapper = alarmMapper;}

    @Override
    public List<AlarmVO> alarmReceivem(AlarmVO avo) {

        return alarmMapper.alarmReceivem(avo);
    }

    @Override
    public List<AlarmVO> alarmReceivec(AlarmVO avo) {
        return alarmMapper.alarmReceivec(avo);
    }

    @Override
    public int deleteAlarm(AlarmVO avo) {

        return alarmMapper.deleteAlarm(avo);
    }

    @Override
    public int alarmSupInsert(AlarmVO avo) {

        return alarmMapper.alarmSupInsert(avo);
    }
}
