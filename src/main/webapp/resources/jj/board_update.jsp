<!-제목: 공지사항 수정 폼->

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
			insert.action = "board_update_go.jsp?key="+key;
			insert.submit();	
		}
}
</script>
</head>
<body>
<h1>공지사항 수정</h1>
<%
	String ids = request.getParameter("key"); //  id
	String title = new String(request.getParameter("title").getBytes("8859_1"),"utf-8"); //  제목
	String text = new String(request.getParameter("text").getBytes("8859_1"),"utf-8"); //  내용
	int id= Integer.parseInt(ids);
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root","koposw");
	Statement stmt =conn.createStatement();
	
	Calendar dateIn = Calendar.getInstance();
	String indate = Integer.toString(dateIn.get(Calendar.YEAR))+"-";
	indate = indate + Integer.toString(dateIn.get(Calendar.MONTH+1))+"-";
	indate = indate + Integer.toString(dateIn.get(Calendar.DATE));
	
	String sql = "select * from board where id="+id+";";
	ResultSet rset = stmt.executeQuery(sql);
	rset.next();
	
	int insert = rset.getInt(1);
	title=rset.getString(2);
	text= rset.getString(4);
	//일단 내용을 보여준다.
	%>
	<form method ='post' name='insert'>
<table border="1" cellpadding="1" cellspacing="0">
<tr>
<td align=center>번호</td>
<td width=700px><%=ids%></td>
</tr>
<tr>
<td align=center>제목</td>
<td width=700px><input type="text" name="title" value="<%=title%>" size=120 maxlength=120></td>
</tr>

<tr>
<td align=center>일자</td>
<td><%=indate%></td>
</tr>

<tr>
<td align=center>내용</td>
<td><textarea name="text" rows="20" cols="100" ><%=text%></textarea></td>
</tr>


<tr>
<td  colspan=2 width=450px align=right><input type=button value="수정" OnClick="ck('yes',<%=ids%>)">
<input type=button value="취소" OnClick="ck('no',<%=ids%>)">
</td></tr>
</table>
</form>

<%			
	stmt.close();
	conn.close();
	rset.close();
%>	
</body>
</html>