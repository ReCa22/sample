package org.interdata.board;

public class BoardVO {

	private int rnum;
	private int num;
	private String id;
	private String contents;
	private java.sql.Date day;
	private String title;
	private int hit;
	private int parent;
	private int indent;
	private String originname;
	private String changename;
	private long file_size;
	
	public int getRnum() {
		return rnum;
	}
	public void setRnum(int rnum) {
		this.rnum = rnum;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public java.sql.Date getDay() {
		return day;
	}
	public void setDay(java.sql.Date day) {
		this.day = day;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
	public int getIndent() {
		return indent;
	}
	public void setIndent(int indent) {
		this.indent = indent;
	}
	public String getOriginname() {
		return originname;
	}
	public void setOriginname(String originname) {
		this.originname = originname;
	}
	public String getChangename() {
		return changename;
	}
	public void setChangename(String changename) {
		this.changename = changename;
	}
	public long getFile_size() {
		return file_size;
	}
	public void setFile_size(long file_size) {
		this.file_size = file_size;
	}
}
