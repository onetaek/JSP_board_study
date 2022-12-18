package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class BoardDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;

	String dbID = "dnjsxorchlrh";
    String dbPassword = "apink419!";
    String dbURL = "jdbc:mysql://localhost:3306/dnjsxorchlrh?useUnicode=true&useJDBCCompliantTimezoneShift"
    		+ "=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
 
    
	public void getCon(){
		 try{   		
			    Class.forName("org.gjt.mm.mysql.Driver");
			    con = DriverManager.getConnection(dbURL, dbID, dbPassword);
		    }catch(Exception e){
		    	e.printStackTrace();
		   	}
	}
	
	
	// 데이터 베이스의 커넥션풀을사용하도록 설정하는 메도스
//	public void getCon() {
//		try {
//			// 커넥션풀에서 DataSource를 사용할 수 있도록하는 세팅
//			Context initctx = new InitialContext();
//			Context envctx = (Context) initctx.lookup("java:comp/env");
//			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
//			con = ds.getConnection();
//		} catch (Exception e) {
//			// TODO: handle exception
//			e.printStackTrace();
//		}
//	}

	// 하나의 새로운 게시글이 넘어와서 저장되는 메소드
	public void insertBoard(BoardBean bean) {
		System.out.println("insertBoard실행");
		getCon();
		// 빈클래스에 넘어오지 않았던 데이터들을 초기화 해주어야 합니다.
		int ref = 0;// 글그룹을 의미 = 쿼리를 실행시켜서 가장큰 ref값을 가져온후 +1을 더해주면됨
		int re_step = 1;// 새글이기때문에 1로준다.
		int re_level = 1;// 새글이기 때문에 1로준다.
		try {
			// 가장큰 ref값을 읽어오는 쿼리 준비
			String refsql = "select max(ref) from board";
			System.out.println(refsql);
			// 쿼리실행 객체
			pstmt = con.prepareStatement(refsql);
			// 쿼리실행 후 결과를 리턴
			rs = pstmt.executeQuery();
			if (rs.next()) {// 결과 값이 있다면
				ref = rs.getInt(1) + 1;// 번째 column의 값, 최대값에 +1을 더해서 글 그룹을 설정
				// 실제로 계시글 전체값을 데이터 테이블에 저장
			}
			String sql = "insert into board values(nextval('board'),?,?,?,?,now(),?,?,?,0,?)";
			pstmt = con.prepareStatement(sql);
			// ?에 값을 맵핑
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, bean.getContent());
			// 쿼리를 실행하시오
			pstmt.executeUpdate();
			con.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	// 모든 게시글을 리턴해주는 게시글작성
		public Vector<BoardBean> getAllBoard(int start, int end) {

			// 리턴할 객체 선언
			Vector<BoardBean> v = new Vector<>();

			getCon();

			try {
				// 쿼리준비
				String sql = "SELECT * FROM (SELECT T.*, @rownum:=@rownum+1 rownum FROM (SELECT @rownum:=0) r,"
						+"(select *from board order by ref desc ,re_step ASC) T) A WHERE rownum >= ? AND rownum <= ?";
				// 쿼리를 실행할 객체선언
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, start-1);
				pstmt.setInt(2, end);
				// 쿼리실행후 결과 저장
				rs = pstmt.executeQuery();
				// 데이터 개수가 몇개인지 모르기에 반복문을 이용하여 데이터를 추출
				while (rs.next()) {
					// 데이터를 패키징(가반 = BoardBean클래스를이용)해줌
					BoardBean bean = new BoardBean();
					bean.setNum(rs.getInt(1));
					bean.setWriter(rs.getString(2));
					bean.setEmail(rs.getString(3));
					bean.setSubject(rs.getString(4));
					bean.setPassword(rs.getString(5));
					bean.setReg_date(rs.getDate(6).toString());
					bean.setRef(rs.getInt(7));
					bean.setRe_step(rs.getInt(8));
					bean.setRe_level(rs.getInt(9));
					bean.setReadcount(rs.getInt(10));
					bean.setContent(rs.getString(11));
					// 패키징한 데이터를 벡터에 저장
					v.add(bean);
				}
				con.close();

			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			return v;

		}

	// BoardInfo 하나의 게시글을 리턴해주는 메소드
	public BoardBean getOneBoard(int num) {

		// 리턴타입 선언
		BoardBean bean = new BoardBean();
		getCon();

		try {
			// 조회수 증가쿼리
			String readsql = "update board set readcount = readcount + 1 where num = ? ";
			pstmt = con.prepareStatement(readsql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			// 쿼리준비
			String sql = "select * from board where num=?";
			// 쿼리실행 객체
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 쿼리실행후 결과를 리턴
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
			}
			con.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return bean;
	}

	// 답변글이 저장되는 메소드
	public void reWriteBoard(BoardBean bean) {

		// 부모글그룹과 글레벨 글스탭을 읽어드림
		int ref = bean.getRef();
		int re_step = bean.getRe_step();
		int re_level = bean.getRe_level();
		System.out.println("ref: " + ref);
		System.out.println("re_step: " + re_step);
		System.out.println("re_level: " + re_level);
		getCon();

		try {
			///////////////// 핵심코드//////////////////
			// 부모 글보다 큰 re_level의 값을 전부 1씩증가 싴켜줌
			String levelsql = "update board set re_level = re_level + 1 where ref=? and re_level > ?";
			// 쿼리실행객체 선언
			pstmt = con.prepareStatement(levelsql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, re_level);
			// 쿼리실행
			pstmt.executeUpdate();
			// 답변글 데이터를 저장
			String sql = "insert into board values(nextval('board'),?,?,?,?,now(),?,?,?,0,?)";
			pstmt = con.prepareStatement(sql);
			// ?에 값을 대입
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);// 부모의 ref값을 넣어줌
			pstmt.setInt(6, re_step + 1);// 답글이기에 부모글에 1을 더해줌
			pstmt.setInt(7, re_level + 1);
			pstmt.setString(8, bean.getContent());
			pstmt.executeUpdate();
			con.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

	}

	// boardUpdate, boardDelte용하나의 게시글을 리턴
	// getOneBoard에 readcount에 +1하는 과정이있어서 거의 같지만 따로만듬
	public BoardBean getOneUpdateBoard(int num) {

		// 리턴타입 선언
		BoardBean bean = new BoardBean();
		getCon();

		try {
			// 쿼리준비
			String sql = "select * from board where num=?";
			// 쿼리실행 객체
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			// 쿼리실행후 결과를 리턴
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bean.setNum(rs.getInt(1));
				bean.setWriter(rs.getString(2));
				bean.setEmail(rs.getString(3));
				bean.setSubject(rs.getString(4));
				bean.setPassword(rs.getString(5));
				bean.setReg_date(rs.getDate(6).toString());
				bean.setRef(rs.getInt(7));
				bean.setRe_step(rs.getInt(8));
				bean.setRe_level(rs.getInt(9));
				bean.setReadcount(rs.getInt(10));
				bean.setContent(rs.getString(11));
			}
			con.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return bean;
	}

	// update와 delete시 필요한 패스워드 값을 리턴해주는 메소드
	public String getPass(int num) {
		// 리턴할 변수 객체 선언
		String pass = "";
		getCon();

		try {
			String sql = "select password from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			// 패스워드 값을 저장
			if (rs.next()) {
				pass = rs.getString(1);
			}
			con.close();

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return pass;
	}

	public void updateBaord(BoardBean bean) {
		getCon();

		try {
			String sql = "update board set subject=?, content=?where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, bean.getSubject());
			pstmt.setString(2, bean.getContent());
			pstmt.setInt(3, bean.getNum());
			pstmt.executeUpdate();
			con.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

	}

	public void deleteBoard(int num) {
		getCon();

		try {
			String sql = "delete from board where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			con.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}

	public int getAllCount() {
		getCon();

		int count = 0;

		try {
			String sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
			con.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

		return count;
	}

	

}
