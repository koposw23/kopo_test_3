<!-제목: 공지사항 글 추가->

<%@page import="java.io.*, java.sql.*,javax.sql.*,java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<script>
function ck(mode,key,rootid){
	if (mode=="no"){
		ins.action = "gongji_list.jsp";
		ins.submit();
		
	}
		else{
			ins.action = "gongji_write.jsp?key="+key+"&rootid="+rootid;
			ins.submit();	
		}
}


</script>
</head>
<body>
</body>
<h1>공지사항 글 추가하기</h1>
<%
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root","koposw");
	Statement stmt =conn.createStatement();
	
	Calendar dateIn = Calendar.getInstance();
	String indate = Integer.toString(dateIn.get(Calendar.YEAR))+"-";
	indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1)+"-";
	indate = indate + Integer.toString(dateIn.get(Calendar.DATE));
	
	String sql = "select max(id), max(rootid) from gongji;";
	ResultSet rset = stmt.executeQuery(sql);
	rset.next();
	int id = rset.getInt(1);
	int rootid = rset.getInt(2)+1;//원글번호가 증가한다.
	%>
	<form method ='post' name='ins'  enctype="multipart/form-data">
<table border="1">
<tr>
<td>번호</td>
<td width=700px align=center><%=id%></td>
</tr>
<tr>
<td>제목</td>
<td width=700px  align=center><input type="text" name="title" value="" size=130 maxlength=130></td>

</tr>
<tr>
<td>일자</td>
<td  align=center><%=indate%></td>
</tr>

<tr>
<td >내용</td>
<td ><textarea name="text" rows="10"  cols="100"></textarea></td>
</tr>

<tr>
<td>사진파일</td>
<td align=cente><input type="file" name="file"></td>
</tr>

<tr>
<td>원글번호</td>
<td width=700px  align=center><%=rootid%></td>
</tr>

<tr>
<td colspan=2 align = right><input type=button value="취소" OnClick="ck('no',0,0)"><input type=button value="쓰기" OnClick="ck('yes',<%=id%>,<%=rootid%>)"></td>
</tr>
</table>
</form>

<%			
	stmt.close();
	conn.close();
	rset.close();
%>	
</body>
</html>