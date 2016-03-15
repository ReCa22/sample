package org.interdata.board;

public class NavigationVO {

	private int currPage;
	private int[] links;
	private boolean leftMore;
	private boolean rigetMore;
	private int infoPage;
	
	public int getCurrPage() {
		return currPage;
	}
	public void setCurrPage(int currPage) {
		this.currPage = currPage;
	}
	public int[] getLinks() {
		return links;
	}
	public void setLinks(int[] links) {
		this.links = links;
	}
	public boolean isLeftMore() {
		return leftMore;
	}
	public void setLeftMore(boolean leftMore) {
		this.leftMore = leftMore;
	}
	public boolean isRigetMore() {
		return rigetMore;
	}
	public void setRigetMore(boolean rigetMore) {
		this.rigetMore = rigetMore;
	}
	public int getInfoPage() {
		return infoPage;
	}
	public void setInfoPage(int infoPage) {
		this.infoPage = infoPage;
	}
	
}
