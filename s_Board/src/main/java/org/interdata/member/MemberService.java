package org.interdata.member;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("membersvc")
public class MemberService {
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
	
	public void insertMember(MemberVO vo){
		MemberDAO dao = sqlSessionTemplate.getMapper(MemberDAO.class);
		dao.insertMember(vo);
	}
	
	public void insertZipCode(MemberVO vo){
		MemberDAO dao = sqlSessionTemplate.getMapper(MemberDAO.class);
		dao.insertZipCode(vo);
	}
	
	public Boolean idCheck(String id){
		MemberDAO dao = sqlSessionTemplate.getMapper(MemberDAO.class);
		boolean isCheck = false;
		MemberVO vo = dao.idCheck(id);
		if(vo != null){
			isCheck = true;
		}
		return isCheck;
	}
	
	public boolean getLoginInfo(String id, String pw){
		MemberDAO dao = sqlSessionTemplate.getMapper(MemberDAO.class);
		boolean isCheck = false;
		MemberVO vo = dao.loginCheck(id, pw);
		if(vo != null){
			isCheck = true;
		}
		return isCheck;
	}
	
	public MemberVO getUserInfo(String id){
		MemberDAO dao = sqlSessionTemplate.getMapper(MemberDAO.class);
		MemberVO vo = dao.getUserInfo(id);
		return vo;
	}
	
	public boolean updateMember(MemberVO vo){
		
		MemberDAO dao = sqlSessionTemplate.getMapper(MemberDAO.class);
		boolean isCheck = false;
		try {
			isCheck = dao.updateMember(vo);
		} catch (Exception e) {
			isCheck = false;
		}
		return isCheck;
	}
	public boolean updateZipCode(MemberVO vo){
		MemberDAO dao = sqlSessionTemplate.getMapper(MemberDAO.class);
		System.out.println("dao.updateZipCode(vo) : " + dao.updateZipCode(vo));
		boolean isCheck = false;
		try {
			isCheck = dao.updateZipCode(vo);
		} catch (Exception e) {
			isCheck = false;
		}
		return isCheck;
	}

}
