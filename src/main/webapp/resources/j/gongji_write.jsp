<!-제목: 공지사항 글 입력하기->

<%@ page import ="com.oreilly.servlet.MultipartRequest" %>
<%@ page import ="com.oreilly.servlet.multipart.FileRenamePolicy" %>
<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@page import="java.io.*, java.sql.*,javax.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
</head>
<body>

<h1>공지사항 글/댓글 입력</h1>
<%////////////////////////////////////////////////////////////////////파일 업로드를 위한 작업	

String saveDirectory=application.getRealPath("DB03/fileupload");
int maxPostSize=10*1024*1024;
String encoding="utf-8";
FileRenamePolicy policy=new DefaultFileRenamePolicy();

MultipartRequest multi=new MultipartRequest(request,saveDirectory,maxPostSize,encoding);
	String fileName=multi.getOriginalFileName("file");
	String ids = request.getParameter("key"); //  id
	String rootids = "0"; //초기값 대입함
	String nodeids = "0";
	String title=null; //그냥 초기값을 넣어준 것임
	rootids = multi.getParameter("rootid"); //  rootid
	nodeids = multi.getParameter("nodeid"); //  nodeid
    title = multi.getParameter("title"); 
	//한글이 깨지지 않게 옮겨담는 정신	
	String text = multi.getParameter("text"); //  

	if(rootids==null || nodeids==null )
	{ //이 경우는 댓글이 아닐경우에 해당함
		nodeids="0";
	}else{
		
	}
	if(title==null){
	%>	
	<script>
	alert("제목을 쓰라규~~~");
	document.location="gongji_list.jsp";
	</script>
	<%
	return;
	}
	else{}
	
	int rootid= Integer.parseInt(rootids);
	int nodeid= Integer.parseInt(nodeids);
	int id=0;
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root","koposw");
	Statement stmt =conn.createStatement();
	String sql="";
	if(ids==null){
	sql="select max(id) from gongji;";
	ResultSet rset = stmt.executeQuery(sql);
	rset.next();
	id = rset.getInt(1);
	}
	else{
		id= Integer.parseInt(ids);
	}
	
	id+=1;

///////////////////////////////////////////////////파일 업로드일 때
if(fileName==null){
	//파일업로드가 없으면 그냥 무시
}else{
Class.forName("com.mysql.jdbc.Driver");
conn = DriverManager.getConnection("jdbc:mysql://localhost/koposw23", "root","koposw");
stmt =conn.createStatement();
sql="insert into file values("+id+",'"+fileName+"');";
stmt.executeUpdate(sql);
}
	
	 
	sql="insert into gongji values("+id+",'"+ title+"',curdate(),'"+text+"',"+rootid+","+nodeid+",0);";
	stmt.executeUpdate( sql );
	stmt.close();
	conn.close();

%>
<script>
alert("<%=title%>이(가) 정상적으로 등록이 되었습니다.");
document.location="gongji_list.jsp";
</script>
</body>
</html>