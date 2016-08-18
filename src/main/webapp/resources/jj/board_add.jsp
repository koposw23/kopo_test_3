<!-제목: 공지사항 댓글입력 폼->

<%@page import="java.io.*, java.sql.*,javax.sql.*,java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<script>
function ck(mode,key){
	if (mode=="no"){
		insert.action = "board_list.jsp";
		insert.submit();
		
	}
		else{
			insert.action = "board_write.jsp";
			insert.submit();	
		}
}
</script>
</head>
<body>
</body>
<h1>공지사항 댓글</h1>
<%
	String ids = request.getParameter("key"); //  id
	String rootids = request.getParameter("rootid"); //  rootid
	String nodeids = request.getParameter("nodeid"); //  nodeid
	String title = new String(request.getParameter("title").getBytes("8859_1"),"utf-8"); //  title
	
	int id= Integer.parseInt(ids);
	int rootid= Integer.parseInt(rootids);
	int nodeid= Integer.parseInt(nodeids);
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root","koposw");
	Statement stmt =conn.createStatement();
	String sql="select id from gonji where rootid="+rootid+" and nodeid="+nodeid+";";

	Calendar dateIn = Calendar.getInstance();
	String indate = Integer.toString(dateIn.get(Calendar.YEAR))+"-";
	indate = indate + Integer.toString(dateIn.get(Calendar.MONTH+1))+"-";
	indate = indate + Integer.toString(dateIn.get(Calendar.DATE));
	
	%>
	<form method ='post' name='insert' enctype="multipart/form-data">
<table border="1" celpadding="0" cellspacing="0">
<tr>
<td align=center>번호</td>
<td width=700px><%=id%></td>
</tr>
<tr>
<td align=center>제목</td>
<td width=700px><input type="text" name="title" 
value="#댓글#<%=title%>" size=120 maxlegnth=120></td>

</tr>
<tr>
<td align=center>일자</td>
<td><%=indate%></td>
</tr>

<tr>
<td align=center>내용</td>
<td ><textarea name="text" rows="20" cols="100" ></textarea></td>
</tr>

<tr>
<td>사진파일</td>
<td align=cente><input type="file" name="file"></td>
</tr>

<tr>
<td align=center>원글</td>
<td width=700px><input type="number" name="rootid" value="<%=rootid%>" hidden><%=rootid%></td>
</tr>

<tr>
<td align=center>댓글레벨</td>
<td width=700px><input type="number" name="nodeid" value="<%=nodeid+1%>" hidden><%=nodeid+1%></td>
</tr>
</table>

<table>
<tr>
<td align=center width=800px><input type=button value="댓글달기" OnClick="ck('yes')"></td>
</tr>
</table>
</form>

<%			
	stmt.close();
	conn.close();
	
%>	
</body>
</html>