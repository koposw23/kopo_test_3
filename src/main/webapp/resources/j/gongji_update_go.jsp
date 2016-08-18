<!-제목: 공지사항 수정 입력->

<%@page import="java.io.*, java.sql.*,javax.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
</head>
<body>

<h1>공지사항 보기</h1>
<%
	String ids = request.getParameter("key"); //  id
	String title = request.getParameter("title"); //  id
	int id= Integer.parseInt(ids);
	
	if(title.length()<=0){
	%>
	
	<script>
	alert("제목을 쓰라규~~~");
	document.location="gongji_list.jsp";
	</script>
	<%
	return;
	}
	else{}

	title = new String(request.getParameter("title").getBytes("8859_1"),"utf-8"); //  제목
	String text = new String(request.getParameter("text").getBytes("8859_1"),"utf-8");  //  내용

	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root","koposw");
	Statement stmt =conn.createStatement();

	String sql="update gongji set title='"+title+"',content='"+text+"' ,date = curdate() where id="+id+";";
	stmt.executeUpdate( sql );
	
	stmt.close();
	conn.close();
%>
공지사항이 수정이 되었습니다.
<script>
document.location="gongji_list.jsp";
</script>
</body>
</html>