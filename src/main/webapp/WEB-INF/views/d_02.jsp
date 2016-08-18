<%@page import="java.io.*, java.sql.*,javax.sql.*,java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<style>
	a{position:absolute; top:10px; left:50px; color:red; font-weight:bold;}
	img.y2{position:absolute; top:10px; left:900px; }
		table{position:absolute; top:40px; left:10px; font-size:20px;}
	
	</style>
</head>
<body bgcolor ="#fff00">
<img class="y2" src="y2.JPG" width="900" height="900">
<%
Class.forName("com.mysql.jdbc.Driver");
   Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/koposw23", "root","koposw");
   Statement stmt =conn.createStatement();
   String sql = "";
   ResultSet rset = null;
   String dates = request.getParameter("date");
   int date=0;
   if(dates==null ){
      sql = "select curdate() from dual;";
   
     
   }else{
      sql = "select curdate() +  interval "+dates+" day from dual;";
      
  
   }
   rset = stmt.executeQuery(sql);
   rset.next();
   dates= rset.getString(1).trim().replace("-","");
   date= Integer.parseInt(dates);
%>
예약하기
<table>
<tr>><td></td><td>날짜</td><td>숙박일</td><td>인원수</td><td>장소</td><td>회원번호</td></tr>
<form method="post" action="book_go.jsp">
<tr>
<td>
숫자만 입력하시오 예:</td><td><input type="number" name="date" value="<%=date%>" cols="10"></td>
<td><input type="number" name="sleep" value="1"></td>
<td><input type="number" name="person" value="1" size=10></td>
<td><select name="place"> <%--장소에 대한 라디오 버튼 --%>
<option value="네오방"  selected>네오방</option> <!- 이것은 html 주석임 ->
<option value="프로도방" >프로도방</option>
<option value="제이지방">제이지방</option>
</select>
<td><input type="text" name="id" value="" size=10></td>
</tr>
<tr>
<td colspan=5 ailgn=right><input type=submit  value='예약하기'></td>
</tr>

</form>
</table>
</body>
</html>