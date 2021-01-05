package controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletContext;
import javax.sql.DataSource;

public class BbsDAO {

	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	
	//기본생성자에서 DBCP(커넥션풀)을 통해 DB연결
	/*
	 인자생성자1 : JSP파일에서 web.xml에 등록된 컨텍스트 초기화 파라미터를 가져와서
	 생성자 호출시 파라미터로 전달한다. 
	*/
	public BbsDAO(String driver, String url, String id, String pw) {
	      try {
	          Class.forName(driver);
	          //DB에 연결된 정보를 멤버변수에 저장
	          con = DriverManager.getConnection(url, id, pw);
	          System.out.println("DB연결 성공");
	       }
	       catch (Exception e) {
	          System.out.println("DB연결 실패");
	          e.printStackTrace();
	       }
	}
	
	/*
	 인자생성자2 : JSP에서는 application 
	 */
	public BbsDAO(ServletContext ctx) {
		try {
			Class.forName(ctx.getInitParameter("MariaJDBCDriver"));
			String id = ctx.getInitParameter("MariaUser");
			String pw = ctx.getInitParameter("MariaPass");
			con = DriverManager.getConnection(
					ctx.getInitParameter("MariaConnectURL"), id, pw);
			System.out.println("DB 연결성공^^*");
					
		} catch (Exception e) {
			System.out.println("DB 연결실패ㅜㅜ;");
			e.printStackTrace();
		}
	}
	
	/*
	 생성자3 : 커넥션풀(DBCP)을 이용한 DB연결
	 */
	   //기본 생성자를 통한 DB연결
	//기본생성자에서 DBCP(커넥션풀)을 통해 DB연결
	public BbsDAO() {
		
		try {
			Context initCtx = new InitialContext();
			Context ctx = (Context)initCtx.lookup("java:comp/env");
			DataSource source = (DataSource)ctx.lookup("jdbc_suamil_db");
			con = source.getConnection();
			System.out.println("DBCP연결성공");
			
		} catch (Exception e) {
			System.out.println("DBCP연결실패");
			e.printStackTrace();
		}
		
	}
	
	/*
	데이터베이스의 연결을 해제할떄 사용.
	컴퓨터는 한정된 자원을 사용하므로 연결했다면 반드시 연결을 해제해줘야 한다. 
	*/
	public void close() {
		try {
			//사용된 자원이 있다면 자원해제 해준다.
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
		} catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}
	
	
///////////////////////////// 관리자 페이지에서 게시판 가져오기///////////////////////////	
	
	//membership테이블과 join해서 게시물 갯수를 카운트
	public int getTotalRecordCountSearch(Map<String, Object> map) {
		
		//게시물의 갯수는 최초 0으로 초기화
		int totalCount = 0;
		
		//기본쿼리문(전체레코드를 대상으로 함)
		String query = "SELECT COUNT(*) FROM board B "
				+ "			INNER JOIN member M "
				+ "				ON B.id=M.id ";
		
		//JSP페이지에서 검색어를 입력한 경우 where절이 동적으로 추가된다.
		if(map.get("Word")!=null) {//여긴 스페이스가 없어서...boardWHERE 요렇게 되는거지...
			query += " WHERE "+ map.get("Column")+" "+" LIKE '%"+map.get("Word")+"%'";
		}
		System.out.println("query="+query);
		
		try {
			//쿼리 실핼 후 결과값 반환
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
			
		} 
		catch (Exception e) {}
		
		return totalCount;
	}
	/*
	게시판 리스트에서 조건에 맞는 레코드를 select하여 ResultSet을 List컬렉션에 
	저장한 후 반환하는 메소드
	*/
	public List<BbsDTO> selectList(Map<String, Object> map){
		
		//리스트 컬렉션을 생성
		List<BbsDTO> bbs = new Vector<BbsDTO>();
		
		//기본쿼리문
		String query = "SELECT * FROM multi_board ";
		
		//검색어가 있을경우 조건절 동적 추가
		if(map.get("Word")!=null) {//여긴 스페이스 있는데...
			query += " WHERE "+map.get("Column")+" "+" LIKE '%"+map.get("Word")+"%'";
		}
		
		// 최근 게시물을 항상 위로 노출해야하므로 작성된 순서의 역순으로 정렬한다.
		query += " ORDER BY num DESC";
		try {
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
		
			//오라클이 반환해준 ResultSet의 갯수만큼 반복
			while (rs.next()) {
				//하나의 레코드를 DTO객체에 저장하기 위해 새로운 객체생성
				BbsDTO dto = new BbsDTO();
				
				//setter()를 통해 각각의 컬럼에 데이터 저장
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString(3));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getInt("visitcount"));
				
				//DTO객체를 List컬렉션에 추
				bbs.add(dto);
			}
		} catch (Exception e) {
			System.out.println("Select1시 예외발생");
			e.printStackTrace();
			
			
		}
		
		return bbs;
	}
	//게시판 리스트+페이지처리+회원이름으로 검색기능 추가
//////// flag받아서 관리자모드에 정보뿌리기
	public List<BbsDTO> selectListPageSearch(String flag){
		
		//리스트 컬렉션을 생성
		List<BbsDTO> bbs = new Vector<BbsDTO>();
		
		//쿼리문이 아래와 같이 페이지처리 쿼리문으로 변경됨
		String query  = " "
				+" SELECT B.*, M.name FROM multi_board B "
				+ " 	INNER JOIN membership M "
				+ "			ON B.id=M.id "
				+ "		WHERE flag=? "
				+ "		ORDER BY num DESC";
		
		//query	+="			ORDER BY num DESC LIMIT ?, ?";
		System.out.println("쿼리문:"+ query);
		
		try {
			
			psmt = con.prepareStatement(query);
			
			//JSP에서 계산한 페이지 범위값을 이용해 인파라미터를 설정함
			/*
			 setString()으로 인파라미터를 설정하면 문자형이 되므로 양쪽에 싱글쿼테이션이 자동으로 기술된다.
			 여기서는 정수로 입력해야하므로 setInt()를 사용하고, 인자로 전달되는 변수를 정수로 변경해야 한다. 
			 */
			psmt.setString(1, flag);

			//psmt.setInt(2, Integer.parseInt(map.get("start").toString()));
			//psmt.setInt(3, Integer.parseInt(map.get("end").toString()));
			
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				BbsDTO dto = new BbsDTO();
				
				dto.setId(rs.getString("id"));
				dto.setNum(rs.getInt("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setAttachedfile(rs.getString("attachedfile"));
				dto.setVisitcount(rs.getInt("visitcount"));
				dto.setFlag(rs.getString("flag"));
				
				//member테이블과의 JOIN으로 이름이 추가됨
				dto.setName(rs.getString("name"));
				
				//DTO객체를 List컬렉션에 추가
				bbs.add(dto);

			}
			
		} catch (Exception e) {
			System.out.println("Select시 예외발생");
			e.printStackTrace();
		}
		
		return bbs;
	}
	
	//일련번호에 해당하는 게시물 하나를 가져온다.
	public BbsDTO selectView(String num) {
		
		BbsDTO dto = new BbsDTO();
		//게시판 테이블만 사용하여 게시물 조회
		//String query = "SELECT * FROM board WHERE num=?";
		
		//게시판, 회원테이블을 조인하여 이름까지 가져와서 조회
		String query = "SELECT " 
				+"    num, title, content, B.id, postdate, visitcount, name, flag "
				+" FROM membership M INNER JOIN multi_board B " 
				+"    ON M.id=B.id " 
				+" WHERE num=? ";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setNum(rs.getInt(1));
				dto.setTitle(rs.getString(2));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getInt(6));
				
				dto.setName(rs.getString(7));
				dto.setFlag(rs.getString("flag"));
			}
		} catch (Exception e) {
			System.out.println("상세보기시 예외발생");
			e.printStackTrace();
		}
		
		return dto;
	}
	
	//글쓰기
	public int insertWrite(BbsDTO dto) {
		
		int affected = 0;
		try {
			/*
			 MariaDB에서는 Sequence대신 auto_increment를 사용하므로 해당 쿼리는 삭제한다.
			 */
			String sql = "INSERT INTO multi_board ("
					+ " title, content, id, attachedfile, visitcount, flag) "
					+ " VALUES ("
					+ " ?, ?, ?, ?, 0, ?)";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			psmt.setString(4, dto.getAttachedfile());
			psmt.setString(5, dto.getFlag());
			
			affected = psmt.executeUpdate();
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		return affected;
	}
	
}
