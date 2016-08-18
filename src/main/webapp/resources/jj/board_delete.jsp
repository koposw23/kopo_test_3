<!-����: �������� �� ����->

<%@page import="java.io.*, java.sql.*,javax.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
</head>
<body>

<h1>?? ????/h1>
<%
	String ids = request.getParameter("key"); //  id
	int id= Integer.parseInt(ids);
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root","koposw");
	Statement stmt =conn.createStatement();
	
	String sql="delete from board where id="+id+";";
	stmt.executeUpdate( sql );
	stmt.close();
	conn.close();
	
%>

���� ������ �Ǿ����ϴ�.
<script>
document.location="board_list.jsp";
</script>
</body>
</html>