package org.spring.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.spring.domain.CalendarVO;
import org.spring.domain.UserVO;

public interface UserMapper {
	public int modifyUser(@Param("type")String type, @Param("value")String value, @Param("key")String key);
	public int removeID(UserVO vo);
	public UserVO showProfile(String id);
	public int createCal(CalendarVO vo);
	public int modifyCal(CalendarVO vo);
	public int removeCal(int calNo);
	public CalendarVO showCal(int calNo);
	public List<CalendarVO> showAllCal(String nickname);
}
