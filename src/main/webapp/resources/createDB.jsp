<%@page import="java.io.*, java.sql.*,javax.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
</head>
<body>
<%
	Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root", "koposw");
		Statement stmt = conn.createStatement();
		String sql="create table book(dates date, person int, place varchar(20), id int, constraint book_pk primary key (dates, place))DEFAULT CHARSET=utf8;";
		PrintWriter pw = response.getWriter();

		try{stmt.execute(sql); //예외가 발생시 메시지를 직접 보여준다.
		   }catch(Exception e){
			   pw.printf(e+"<br>");
				
			try{sql="create table operate(dates date, sleep int, id int);";
				stmt.execute(sql);}catch(Exception e2){
					pw.printf(e2+"%d번째 예외발생\n",2);
					}
			
			}
		
		


stmt.close();
conn.close();
%>
<script>
document.location="f_01.jsp";
</script>
</body>
</html>