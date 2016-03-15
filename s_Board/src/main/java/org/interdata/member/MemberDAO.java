package org.interdata.member;

import org.apache.ibatis.annotations.Param;

public interface MemberDAO {

	public void insertMember(MemberVO vo);
	public void insertZipCode(MemberVO vo);
	public MemberVO idCheck(String id);
	public MemberVO loginCheck(@Param(value="id")String id, @Param(value="pw")String pw);
	public MemberVO getUserInfo(String id);
	public boolean updateMember(MemberVO vo);
	public boolean updateZipCode(MemberVO vo);
	public MemberVO getPw(MemberVO vo);
}
