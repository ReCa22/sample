package org.interdata.email;

public class EmailVO {

	private String subject;
    private String content;
    private String date;
    private String receiver1;
    private String receiver2;
    private boolean result;
    private boolean emailOverlab;
    
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getReceiver1() {
		return receiver1;
	}
	public void setReceiver1(String receiver1) {
		this.receiver1 = receiver1;
	}
	public String getReceiver2() {
		return receiver2;
	}
	public void setReceiver2(String receiver2) {
		this.receiver2 = receiver2;
	}
	public boolean isResult() {
		return result;
	}
	public void setResult(boolean result) {
		this.result = result;
	}
	public boolean isEmailOverlab() {
		return emailOverlab;
	}
	public void setEmailOverlab(boolean emailOverlab) {
		this.emailOverlab = emailOverlab;
	}
    
}
