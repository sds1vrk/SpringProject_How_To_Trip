package story;

import java.util.*;
import java.sql.*;
import conn.*;
import encoding.TextToHTML;

public class StoryDAO {
	private Connection conn;
	private SuperConn connMaker = new DBConnOracle();
	private TextToHTML tth=new TextToHTML();
	
	private PreparedStatement ps;
	private static StoryDAO dao;
	public static ArrayList<SnapVO> list=new ArrayList<>();
	
	public static StoryDAO newInstance() {
		if(dao==null)
			dao=new StoryDAO();
		
		return dao;
	}
	//--------------------------기능----------------------------------

//------------------------------읽기---------------------------------------	
	public List<StoryVO> storyAllData() { //모든 스토리 불러옴
		List<StoryVO> list=new ArrayList<>();
		try {
			conn=connMaker.getConnection();
			String sql="SELECT ST_ID,ST_IMG, USER_ID, ST_NM "
					+ "FROM STORY ORDER BY ST_ID ASC";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				StoryVO vo=new StoryVO();
				vo.setStoryno(rs.getInt(1));
				vo.setTitleimage(tth.replaceHtml(rs.getString(2)));
				vo.setId(tth.replaceHtml(rs.getString(3)));
				vo.setStoryname(tth.replaceHtml(rs.getString(4)));
				list.add(vo);
			}
			rs.close();
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}finally {
			connMaker.disConnection(conn,ps);
		}
		return list;
	}
	
	public List<StoryVO> storyPageData(int page) {
		List<StoryVO> list=new ArrayList<>();
		try {
			conn=connMaker.getConnection();
			String sql="SELECT ST_ID,ST_IMG, USER_ID, ST_NM "
					+ "FROM (SELECT ST_ID,ST_IMG, USER_ID, ST_NM, ROWNUM FROM STORY ORDER BY ST_ID ASC) "
					+ "WHERE \"ROWNUM\" BETWEEN ? AND ?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, (page-1)*8+1);
			ps.setInt(2, page*8);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				StoryVO vo=new StoryVO();
				vo.setStoryno(rs.getInt(1));
				vo.setTitleimage(tth.replaceHtml(rs.getString(2)));
				vo.setId(tth.replaceHtml(rs.getString(3)));
				vo.setStoryname(tth.replaceHtml(rs.getString(4)));
				list.add(vo);
			}
			rs.close();
			
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}finally {
			connMaker.disConnection(conn,ps);
		}
		return list;
	}
	
	public StoryVO getStoryVO(int st_id) { //스토리 1개 가져옴
		StoryVO vo=new StoryVO();
		try {
			if(conn!=null) {
				connMaker.disConnection(conn,ps);
			}
			conn=connMaker.getConnection();
			conn.setAutoCommit(false);
			
			String sql="SELECT ST_NM, ST_IMG, USER_ID FROM STORY WHERE ST_ID=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, st_id);
			ResultSet rs=ps.executeQuery();
			rs.next();
			vo.setStoryname(tth.replaceHtml(rs.getString(1)));
			vo.setTitleimage(tth.replaceHtml(rs.getString(2)));
			vo.setId(rs.getString(3));
			rs.close();
		}catch(Exception ex) {
			System.out.println("getStoryVO 오류");
		}
		return vo;
	}
	
	public List<StoryVO> storyUserData(String user_id) { //사용자 스토리 불러옴
		List<StoryVO> list=new ArrayList<>();
		try {
			conn=connMaker.getConnection();
			String sql="SELECT ST_ID,ST_IMG, USER_ID, ST_NM "
					+ "FROM STORY WHERE USER_ID=?";
			ps=conn.prepareStatement(sql);
			ps.setString(1, user_id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				StoryVO vo=new StoryVO();
				vo.setStoryno(rs.getInt(1));
				vo.setTitleimage(tth.replaceHtml(rs.getString(2)));
				vo.setId(tth.replaceHtml(rs.getString(3)));
				vo.setStoryname(tth.replaceHtml(rs.getString(4)));
				list.add(vo);
			}
			rs.close();
			
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}finally {
			connMaker.disConnection(conn,ps);
		}
		return list;
	}
	
	public List<SnapVO> snapAllData(int st_id) { //1개에 스토리에 대한 스냅들 가져오기
		List<SnapVO> list=new ArrayList<>();
		try {
			conn=connMaker.getConnection();
			conn.setAutoCommit(false);
			String sql="SELECT SN_ID, ST_ID, SN_ORD, SN_IMG, SN_CON "
					+ "FROM SNAP WHERE ST_ID=? ORDER BY SN_ORD ASC";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, st_id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				SnapVO vo=new SnapVO();
				vo.setSnapno(rs.getInt(1));
				vo.setStoryno(rs.getInt(2));
				vo.setNumbering(rs.getInt(3));
				vo.setSnapimg(tth.toTEXT(rs.getString(4)));
				vo.setSnapcontent(tth.toTEXT(rs.getString(5)));
				list.add(vo);
			}
			rs.close();
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}finally {
			connMaker.disConnection(conn,ps);
		}
		return list;
	}
	
	public SnapVO snapDetailData(int SN_ID) { //스냅1개 얻기
		SnapVO vo=new SnapVO();
		try {
			conn=connMaker.getConnection();
			String sql="SELECT SN_ID, ST_ID, SN_ORD, SN_IMG, SN_CON"
					+ " FROM SNAP WHERE SN_ID=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, SN_ID);
			ResultSet rs=ps.executeQuery();
			rs.next();
				vo.setSnapno(rs.getInt(1));
				vo.setStoryno(rs.getInt(2));
				vo.setNumbering(rs.getInt(3));
				vo.setSnapimg(tth.replaceHtml(rs.getString(4)));
				vo.setSnapcontent(tth.replaceHtml(rs.getString(5)));
				rs.close();
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}finally {
			connMaker.disConnection(conn,ps);
		}
		return vo;
	}
	
	public List<CommentVO> getComment(int sn_id) { //스냅에 대한 댓글 불러오기
		List<CommentVO> list=new ArrayList();
		try {
			conn=connMaker.getConnection();
			String sql="SELECT CM_ID, SN_ID, USER_ID, CM_CON"
					+ " FROM COMMENTS WHERE SN_ID=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, sn_id);
			ResultSet rs=ps.executeQuery();
			while(rs.next()) {
				CommentVO vo=new CommentVO();
				vo.setCommentno(rs.getInt(1));
				vo.setSnapno(rs.getInt(2));
				vo.setId(tth.replaceHtml(rs.getString(3)));
				vo.setCommentContent(tth.replaceHtml(rs.getString(4)));
				list.add(vo);
			}
			rs.close();
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
			System.out.println("댓글 불러오기 실패");
		}finally {
			connMaker.disConnection(conn,ps);
		}
		return list;
	}
	
	public int getMaxStoryno() { //스토리 최대 넘버
		int max=0;
		try {
			String sql="SELECT NVL(max(ST_ID),1) FROM STORY";
			ps=conn.prepareStatement(sql);
			ResultSet rs=ps.executeQuery();
			rs.next();
			max=rs.getInt(1);
			rs.close();
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		return max;
	}
	
	public SnapVO snapUpdateData(int st_id, int sn_ord) { //스냅1개  업데이트 정보 얻기 
		SnapVO vo=new SnapVO();
		try {
			String sql="SELECT SN_IMG, SN_CON "
					+ "FROM SNAP WHERE ST_ID=? AND SN_ORD=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, st_id);
			ps.setInt(2, sn_ord);
			ResultSet rs=ps.executeQuery();
			System.out.println("시발");
			rs.next();
			System.out.println(rs.getString(1));
			System.out.println(rs.getString(2));
			vo.setSnapimg(tth.replaceHtml(rs.getString(1)));
			vo.setSnapcontent(tth.replaceHtml(rs.getString(2)));
			rs.close();
		}catch(Exception ex) {
			System.out.println("스냅정보 로드실패");
		}
		return vo;
	}
	
	public int lastOfSnap(int st_id) { //스냅의 마지막 오더를 가져옴
		int max=0;
		try {
			String sql="SELECT MAX(SN_ORD) FROM SNAP WHERE ST_ID=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, st_id);
			ResultSet rs=ps.executeQuery();
			rs.next();
			max=rs.getInt(1);
		}catch(Exception ex) {
			System.out.println("lastOfSnap 실패");
		}
		return max;
	}

//----------------------------생성
	public void insertStory(String st_img,String user_id,String st_nm) { //스토리 삽입
		try {
			if(conn!=null) {
				connMaker.disConnection(conn,ps);
			}
			conn=connMaker.getConnection();
			conn.setAutoCommit(false);
			String sql="INSERT INTO story(ST_ID,ST_IMG,USER_ID,ST_NM) "
					+ "VALUES((SELECT NVL(max(ST_ID)+1,1) FROM STORY),?,?,?)";
			ps=conn.prepareStatement(sql);
			
			st_img=tth.toTEXT(st_img);
			user_id=tth.toTEXT(user_id);
			st_nm=tth.toTEXT(st_nm);
			ps.setString(1, st_img);
			ps.setString(2, user_id);
			ps.setString(3, st_nm);
			ps.executeUpdate();
			System.out.println("스토리가 추가되었습니다!");
		}catch(Exception ex) {
			System.out.println("스토리 추가 실패");
		}
	}
	
	public void insertSnap(int st_id, int sn_ord, String sn_img, String sn_con) { //스냅 삽입
		try {
			String sql="INSERT INTO SNAP(SN_ID,ST_ID,SN_ORD,SN_IMG,SN_CON) "
					+ "VALUES((SELECT NVL(max(SN_ID)+1,1) FROM SNAP),?,?,?,?)";
			ps=conn.prepareStatement(sql);
			
			ps.setInt(1, st_id);
			ps.setInt(2, sn_ord);
			sn_img=tth.toTEXT(sn_img);
			sn_con=tth.toTEXT(sn_con);
			ps.setString(3, sn_img);
			ps.setString(4, sn_con);
			ps.executeUpdate();
			System.out.println("스냅이 추가되었습니다!");
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	
	public void insertComment(int sn_id, String user_id, String cm_con) {  //댓글 삽입
		try {
			conn=connMaker.getConnection();
			String sql="INSERT INTO COMMENTS "
					+ "VALUES((SELECT NVL(max(CM_ID)+1,1) FROM COMMENTS),?,?,?)";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, sn_id);
			user_id=tth.toTEXT(user_id);
			cm_con=tth.toTEXT(cm_con);
			ps.setString(2, user_id);
			ps.setString(3, cm_con);
			ps.executeUpdate();
			System.out.println("댓글 삽입 성공");
		}catch(Exception ex) {
			System.out.println("댓글 삽입 실패");
		}finally {
			connMaker.disConnection(conn,ps);
		}
	}
	
//----------------------------수정
	public void updateStory(int st_id, String st_nm, String st_img) {  //스토리 업데이트
		try {
			String sql="UPDATE STORY SET ST_NM=?,"
					+ "	ST_IMG=? WHERE ST_ID=?";
			ps=conn.prepareStatement(sql);
			st_nm=tth.toTEXT(st_nm);
			st_img=tth.toTEXT(st_img);
			ps.setString(1, st_nm);
			ps.setString(2, st_img);
			ps.setInt(3, st_id);
			ps.executeUpdate();
			System.out.println("스토리 업데이트 성공");
		}catch(Exception ex) {
			System.out.println("updateStory실패");
		}
	}
	
	public void updateSnap(int st_id, int sn_ord, String sn_img, String sn_con) { //스냅 업데이트
		try {
			String sql="UPDATE SNAP SET SN_IMG=?,"
					+ "SN_CON=? "
					+ "WHERE ST_ID=? AND SN_ORD=?";
			ps=conn.prepareStatement(sql);
			sn_img=tth.toTEXT(sn_img);
			sn_con=tth.toTEXT(sn_con);
			ps.setString(1, sn_img);
			ps.setString(2, sn_con);
			ps.setInt(3, st_id);
			ps.setInt(4, sn_ord);
			ps.executeUpdate();
			System.out.println("스냅 업데이트 성공");
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
	
	//스냅번호 재정리
	public void snapNumberOrder(int st_id,int sn_ord) {
		try {
			String sql="UPDATE SNAP SET SN_ORD=SN_ORD-1 "
					+ "WHERE ST_ID=? AND SN_ORD>?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, st_id);
			ps.setInt(2, sn_ord);
			ps.executeQuery();
			System.out.println("스냅번호 정리 완료");
		}catch(Exception ex){
			System.out.println("snapNumberOrder실패");
		}
	}
//----------------------------삭제
	public void deleteStory(int st_id) { //스토리 삭제 
		try {
			conn=connMaker.getConnection();
			String sql="DELETE story WHERE ST_ID=?";
			ps=conn.prepareStatement(sql);
			ps.setInt(1, st_id);
			ps.executeUpdate();		
		}catch(Exception ex){
			System.out.println("삭제실패");
		}finally {
			connMaker.disConnection(conn,ps);
		}
	}
	
	public void deleteSnap(int st_id, int sn_ord) { //스냅 1개 삭제
		try {
			String sql="DELETE SNAP WHERE ST_ID=? AND SN_ORD=?";
			System.out.println(st_id+" "+sn_ord);
			ps=conn.prepareStatement(sql);
			ps.setInt(1, st_id);
			ps.setInt(2, sn_ord);
			ps.executeUpdate();
			System.out.println("스냅 삭제 성공");
			snapNumberOrder(st_id, sn_ord);
		}catch(Exception ex) {
			System.out.println("deleteSnap 실패");
		}
	}
//-----------------------------기타
	public void commit() {
		try {
			conn.commit();
			System.out.println("커밋완료 되었습니다.");
			conn.setAutoCommit(true);
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}finally {
			connMaker.disConnection(conn,ps);
		}
	}
	
	public void rollback() {
		try {
			conn.rollback();
			System.out.println("롤백완료 되었습니다.");
		}catch(Exception ex) {
			System.out.println(ex.getMessage());
		}finally {
			connMaker.disConnection(conn,ps);
		}
	}

}



