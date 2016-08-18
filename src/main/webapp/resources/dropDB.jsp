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
		String sql="drop table book;";
		PrintWriter pw = response.getWriter();

		try{stmt.execute(sql); //���ܰ� �߻��� �޽����� ���� �����ش�.
		   }catch(Exception e){
			   pw.printf(e+"<br>");
				
			try{sql="drop table operate;";
				stmt.execute(sql);}catch(Exception e2){
					pw.printf(e2+"%d��° ���ܹ߻�\n",2);
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