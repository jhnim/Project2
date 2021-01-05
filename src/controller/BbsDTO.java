package controller;

/*
 DTO 클래스를 만들때는 테이블정의서를 참조한다.
 기본적으로 테이블과 동일한 형태로 멤버변수를 정의하면 된다.
 멤버변수의 타입은 특별한 경우를 제외하고는 대부분 String으로 정의한다.
 꼭 필요한 경우에만 int, double로 정의한다.
 */
public class BbsDTO {
	
    private String id; //작성자 아이디(membership테이블 참조)
	private int num; // 일련번호
	private String title; //제목
	private String content; // 내용
	private java.sql.Date postdate; // 작성일
	private String attachedfile; // 첨부파일
	private int visitcount; // 조회수
	private String flag; // 게시판테이블
	
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	/*
	 회원테이블과 join하여 이름을 가져오기 위해 DTO클래스에 name컬럼을 추가한다. 
	 */
	private String name;
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public java.sql.Date getPostdate() {
		return postdate;
	}
	public void setPostdate(java.sql.Date postdate) {
		this.postdate = postdate;
	}
	public String getAttachedfile() {
		return attachedfile;
	}
	public void setAttachedfile(String attachedfile) {
		this.attachedfile = attachedfile;
	}
	public int getVisitcount() {
		return visitcount;
	}
	public void setVisitcount(int visitcount) {
		this.visitcount = visitcount;
	}
}
