<!--예약 삭제-->
<%@page import="java.io.*, java.sql.*,javax.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
</head>
<body>

<h1>글 삭제</h1>
<%
	String ids = request.getParameter("id"); //  id
	String dates = request.getParameter("dates"); //  id
	String sleeps = request.getParameter("sleep"); //  id
	String place = new String(request.getParameter("place").getBytes("8859_1"),"utf-8"); //  id
	String persons = request.getParameter("person"); //  id
	String k01=dates.substring(0,4);
	String k02=dates.substring(4,6);
	String k03=dates.substring(6,8);

	out.println(ids+persons+dates+sleeps+place);
	int id= Integer.parseInt(ids);
	int person= Integer.parseInt(persons);
	int sleep= Integer.parseInt(sleeps);
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root", "koposw");
	Statement stmt =conn.createStatement();
	String sql="";
	int i=0;
	ResultSet rset=null;
	try{
	String gone[]=new String[sleep]; //숙박기간을 구하기 위한 배열선언
	
	for(i=0;i<sleep;i++){  //숙박기간을 구한다.
		sql="select '"+dates+"'+ interval "+i+" day from dual;";
		rset = stmt.executeQuery(sql);
		rset.next();
		gone[i]=rset.getString(1);
	}
	for(i=0;i<sleep;i++){ //숙박기간을 예약테이블에서 지운다.
		sql="delete from book where place='"+place+"' and dates='"+gone[i]+"' and id="+id+" ;";
		stmt.executeUpdate(sql);
	}
	
	sql="delete from operate where id="+id+" and dates='"+dates+"';";
	stmt.executeUpdate( sql );
	}catch(Exception e){
		%>
		<script>
		alert("<%=e%>");
		</script>
		<%
	}
	rset.close();
	stmt.close();
	conn.close();
	
%>

글이 삭제가 되었습니다.
<script>
alert("<%=dates%>일자 장소는<%=place%>인 회원id<%=id%>가 삭제되었습니다.");
document.location="f_01.jsp";
</script>
</body>
</html>