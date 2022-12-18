package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BoardDAO {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public void getCon() {
		try {
			// 커넥션풀에서 DataSource를 사용할 수 있도록하는 세팅
			Context initctx = new InitialContext();
			Context envctx = (Context) initctx.lookup("java:comp/env");
			DataSource ds = (DataSource) envctx.lookup("jdbc/pool");
			con = ds.getConnection();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	//전체 글의 갯수를 리턴하는 메소드
	public int getAllCount() {
		getCon();
		int count = 0;
		try {
			String sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				count = rs.getInt(1);
			}
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	
	public Vector<BoardBean> getAllBoard(int startRow, int endRow){
		Vector<BoardBean> v = new Vector<BoardBean>();
		System.out.println("startRow: " +startRow +"endRow: "+ endRow);
		getCon();
		try {
//			String sql = "SELECT * FROM (SELECT T.*, @rownum:=@rownum+1 rownum FROM (SELECT @rownum:=0) r,"
//					+"(select *from board order by ref desc ,re_step ASC) T) A WHERE rownum >= ? AND rownum <= ?";
			String sql = "select * from board order by ref desc, re_step asc limit ?, ?";
			//쿼리실행할 객체 선언
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
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
				//패키징한 데이터를 벡터에 저장
				v.add(bean);
			}
			con.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return v;
	}
	
	//하나의 게시글을 저장하는 메소드를 호출
	public void insertBoard(BoardBean bean) {
		getCon();
		
		int ref = 0;
		int re_step = 1;//새글이기에
		int re_level = 1;//새글이기에
		
		try {
			String refsql = "select max(ref) from board";
			pstmt = con.prepareStatement(refsql);
			//쿼리 실행후 결과를 리턴
			rs = pstmt.executeQuery();
			if(rs.next()) {
				ref = rs.getInt(1)+1;//가장 큰 값에 1을 더한값	
			}
			String sql = "insert into board values(nextval('board'),?,?,?,?,now(),?,?,?,0,?)";
			pstmt = con.prepareStatement(sql);
			// ?에 맵핑
			pstmt.setString(1, bean.getWriter());
			pstmt.setString(2, bean.getEmail());
			pstmt.setString(3, bean.getSubject());
			pstmt.setString(4, bean.getPassword());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, bean.getContent());
			pstmt.executeUpdate();
			con.close();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public BoardBean getOneBoard(int num) {
		
		getCon();
		BoardBean bean = null;
		
		try {
			//하나의 게시글을 읽었다는 조회수 증가
			String countsql = "update board set readcount = readcount+1 where num = ?";
			pstmt = con.prepareStatement(countsql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			//쿼리 준비
			String sql = "select * from board where num = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			//쿼리 실행 후 결과를 리턴
			rs = pstmt.executeQuery();
			if(rs.next()) {
				bean = new BoardBean();
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
			e.printStackTrace();
		}		
		return bean;

	}
	
	//답변글을 저장하는 메소드
	public void reInsertBoard(BoardBean bean) {		
		
		getCon();
		int ref = bean.getRef();
		int re_step = bean.getRe_step();
		int re_level = bean.getRe_level();
		
		try {
			/////////////////////핵심 코드//////////////////////
			//부모 글보다 큰 re_level의 값을 전부 1씩 증가 시켜줌
			String levelsql = "update board set re_level = re_level + 1 where ref = ? and re_level > ?";
			//쿼리 실행 객체 선언
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
	
	
}
