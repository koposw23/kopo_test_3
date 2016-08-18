<!-제목: DB 테이블생성->

<%@page import="java.io.*, java.sql.*,javax.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
</head>
<body>
<%		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root", "koposw");
		Statement stmt = conn.createStatement();
		String sql="drop table gongji;";
		PrintWriter pw = response.getWriter();
		boolean fault=false;
		try{stmt.execute(sql); //예외가 발생시 메시지를 직접 보여준다.
		   }catch(Exception e){
			   pw.printf(e+"<br>");
			   fault=true;
		   }	
			try{sql="drop table file;";
					stmt.execute(sql);
					if(fault==false){ 		%>
<script>
alert("이제 테이블은 삭제되었습니다.(it's made.)");
</script>
<%
					}				
				}catch(Exception e2){
					pw.printf(e2+"%d번째 예외발생\n",2);
					}			
stmt.close();
conn.close();
%>
<script>
document.location="f_01.jsp";
</script>
</body>
</html>