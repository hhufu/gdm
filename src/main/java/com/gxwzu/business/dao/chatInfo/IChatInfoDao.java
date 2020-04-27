package com.gxwzu.business.dao.chatInfo;

import java.util.List;

import com.gxwzu.business.model.chatInfo.ChatInfo;
import com.gxwzu.core.dao.BaseDao;
import com.gxwzu.core.pagination.Result;
import com.gxwzu.sysVO.ListChatInfo;
import com.gxwzu.sysVO.ListStudentAllotGuide;

public interface IChatInfoDao extends BaseDao<ChatInfo> {
	
	public Result<ChatInfo> find(ChatInfo model, int page, int size);

	public List<ChatInfo> findByExample(ChatInfo model);

	/**
	 * 查询聊天记录 通过当前用户id 和 被回复人ID
	 * 
	 * @param userId
	 *            当前用户id
	 * @param answerId
	 *            被回复人ID
	 * @return
	 */
	public List<ChatInfo> findByUserIdAndAnswerId(Integer userId,
			Integer answerId,String chatType);
	/**
	 * 查询当前指导老师所带学生的所有聊天记录  通过当前用户id 和 被回复人ID
	 * @param treacherId
	 * @param chatType 
	 * @return
	 */
	public List<ChatInfo> findByGuideTreacherId(Integer treacherId,
			Integer year, String chatType, List<ListStudentAllotGuide> allotGuideStudentList);

	public List<ChatInfo> findByAnswerId(Integer answerId,Integer senderId ,String chatType, String readType);


	/**
	 * 更新消息阅读状态
	 * @param readType 
	 * @param readType
	 */
	public void updateReadType(Integer answerId, Integer senderId, String readType);

	public void updateByChatId(Integer chatId, String readType);

    Integer findChatCountByTeacherIdOrStudentId(Integer userId);
}