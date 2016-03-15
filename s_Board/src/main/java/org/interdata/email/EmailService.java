package org.interdata.email;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.interdata.member.MemberDAO;
import org.interdata.member.MemberVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service("emailService")
public class EmailService {
	
	@Autowired
    protected JavaMailSender  mailSender;
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;
/////////////이메일 인증/////////////////////////
    public boolean sendMail(EmailVO email) throws Exception {
        try{
	        MimeMessage msg = mailSender.createMimeMessage();
	        msg.setFrom("gyung2045@naver.com"); // 송신자를 설정해도 소용없지만 없으면 오류가 발생한다
	        msg.setSubject(email.getSubject());
	        msg.setText(email.getContent());
	        String fullMsg = email.getReceiver1()+"@"+email.getReceiver2();
	        msg.setRecipient(RecipientType.TO , new InternetAddress(fullMsg));
	         
	        mailSender.send(msg);
	        email.setResult(true);
	        System.out.println(email.isResult());
	        return true;
        }catch(Exception ex) {
        	ex.printStackTrace();
        }
        return false;
    }
    public MemberVO getMemberInfo(MemberVO vo){
    	MemberDAO dao = sqlSessionTemplate.getMapper(MemberDAO.class);
    	return dao.getPw(vo);
    }
	
}
