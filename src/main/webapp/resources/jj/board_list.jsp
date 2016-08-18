<!-제목: 공지사항 글 목록->

<%@page import="java.io.*, java.sql.*,javax.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<style>
	img.y1{position:absolute; top:30px; left:1000px; }	
	</style>
</head>
<body bgcolor ="#fff00">
<img class="y1" src="y1.JPG" width="1000" height="800">
<h1>카카오팬션 이용후기</h1>
<%	
	String type=request.getParameter("type");
	String content=request.getParameter("content");
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root","koposw");
	Statement stmt =conn.createStatement();
	String sql=null;
	 out.println(content);
		
	if(type==null){
		sql="select * from board order by rootid desc, nodeid asc;";
	}else if(type.equals("title")){
		sql="select * from board where title like '%"+content+"%' order by rootid desc, nodeid asc ;";
	}else if(type.equals("titleText")){
		sql="select * from board where title like '%"+content+"%' or content like '%"+content+"%' order by rootid desc, nodeid asc ;";
	}else{
		sql="select * from board where content like '%"+content+"%' order by rootid desc, nodeid asc ;";
	}
	ResultSet rset =stmt.executeQuery( sql );
%>
<table border="1">
<tr>
<td align=center>번호</td><td width=700px align=center>제목</td><td align=center >조회수</td>
<td width=100px align=center>등록일</td>
</tr>
<%
	while(rset.next())
	{
%>
<tr><!--공지사항 리스트 출력부분-->
		<td align=center><%=rset.getInt(1)%></td>
		<td align=center><a href="board_view.jsp?id=<%=rset.getInt(1)%>&rootid=<%=rset.getInt(5)%>&nodeid=<%=rset.getInt(6)%>"><%=rset.getString(2)%></td>
		<td align=center><%=rset.getInt(7)%></td>  
		<td align=center><%=rset.getString(3)%></td>  
		</td>
</tr>
<%		
	}
	stmt.close();
	conn.close();
	rset.close();
%>	
</table>
<table><tr>
<form action="board_list.jsp">
<td align=right>
<select name="type"> <%--찾는 부분을 라디오 버튼으로 함, -% 이것은 jsp주석임 --%>
<option value="title"  selected>제목</option> <!- 이것은 html 주석임 ->
<option value="text" >내용</option>
<option value="titleText">제목+내용</option>
</select>
<input type="text" name="content" value="" size=115 maxlength=115>
<input type=submit  value='찾기'></td>
</form>
<form action="board_insert.jsp">
<td align=right>
<input type=submit  value='추가'></td>
</form>	
</tr>
</table>
</body>
</html>