<%@page import="java.io.*, java.sql.*,javax.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<style>
	a.y1{position:absolute; top:10px; left:50px; color:red; font-weight:bold;}
	img.y2{position:absolute; top:10px; left:900px; }
	a.y3{position:relative:10px; left:900px; }
		table{position:absolute; top:40px; left:10px; font-size:20px;}
	
	</style>
</head>
<body bgcolor ="#fff00">
<img class="y2" src="y2.JPG" width="900" height="900">
<a class="y1">카카오팬션 예약상황</a>
<%   
   Class.forName("com.mysql.jdbc.Driver");
   Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root","koposw");
   Statement stmt =conn.createStatement();
   String sql=null;
   int day=0;//day는 30일까지 출력하기 위한 변수
%>
<table border="1">
<tr>

</tr>
<%
   while(day<30)
   {
      if(day%7==0){
%>
<tr>
<%
      }else{}
   sql="select curdate()+ interval "+day+" day from dual;";
   ResultSet rset=stmt.executeQuery(sql);
   rset.next();
%>
<td><%=rset.getString(1)%>
<% 
   sql=" select count(distinct place) from book where not place "+
   "in ( select place from book where dates = curdate()+ interval "+day+" day);";//빈 방의 갯수세기
   rset = stmt.executeQuery( sql );
   rset.next();
   int none= rset.getInt(1);
   
   sql="select place,id from book where dates=curdate()+ interval "+day+" day;";
   rset =stmt.executeQuery( sql );
%>   
   <br>
<%
   while(rset.next()){      
%>
   <%=rset.getString(1)%><br>
 <%            
   }
   if(none>0){
      sql="select distinct  place from book where not place in ( select place from book where dates = curdate()+ interval "+day+" day);";
      rset = stmt.executeQuery(sql);
   while(rset.next()){   
%>
   <a class="y3" href="d_02.jsp?date=<%=day%>"><%=rset.getString(1)%></a><br>
<%      
      }
   }
%>
</td>
<%
if(day%7==6){
%>
</tr>
<%
}
else{}
   day++;
    rset.close();
   }
   stmt.close();
   conn.close();

%>   
</body>
</html>
</body>
</html>