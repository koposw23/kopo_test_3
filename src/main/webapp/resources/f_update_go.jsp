<!--예약 수정실행-->
<%@page import="java.io.*, java.sql.*,javax.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
</head>
<body>

<h1>펜션예약 수정</h1> <!- operate은 날짜계산 테이블 book은 예약완료된 테이블 ->
<%
	String date = request.getParameter("dates"); //  회원이 입력한 숙박시작날짜	
	String gonedate = request.getParameter("gonedate"); //  회원이 입력한 숙박시작날짜
	String sleeps = request.getParameter("sleep"); //  숙박기간
	String gonesleeps = request.getParameter("gonesleep"); //  숙박기간
	String persons = request.getParameter("person"); //  인원수
	String place =new String(request.getParameter("place").getBytes("8859_1"),"utf-8"); //  장소
	String goneplace =request.getParameter("goneplace"); //  장소	
	String gonepersons =request.getParameter("goneperson"); //  장소	
	String ids = request.getParameter("id"); //  회원번호
	String k01=date.substring(0,4);
	String k02=date.substring(4,6);
	String k03=date.substring(6,8);
	out.println(date+"p"+gonedate+goneplace+place+"p"+gonepersons+persons+"p"
	+gonesleeps+sleeps);
	date=k01+"-"+k02+"-"+k03; //날짜를 받아올 때 '-'가 안되서 숫자를 입력받아 다시 붙임

	
	if(date.length()<=0 ||sleeps.length()<=0 ||persons.length()<=0 ||ids.length()<=0  ){
	%>
	
	<script>
	alert("입력사항이 부족합니다.");
	document.location="index.jsp";
	</script>
	<%
	return;
	}

	
	int sleep= Integer.parseInt(sleeps);
	int gonesleep= Integer.parseInt(gonesleeps);
	int person= Integer.parseInt(persons);
	int id= Integer.parseInt(ids);
	
	
	Class.forName("com.mysql.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root", "koposw");
	Statement stmt =conn.createStatement();
	String sql="";
	int i=0;//for를 위한 변수
	String gone[]=new String[gonesleep];
	///////////////////////////////////////////////////////////////////////////////////////수정 전에 입력되었던 것을 지운다.
	for(i=0;i<gonesleep;i++){  //먼저 숙박한 기간을 구한다.
		sql="select '"+gonedate+"'+ interval "+i+" day from dual;";
		ResultSet rset = stmt.executeQuery(sql);
		rset.next();
		gone[i]=rset.getString(1);
	}
	
	for(i=0;i<gonesleep;i++){
		sql="delete from book where place='"+goneplace+"' and dates='"+gone[i]+"' and id="+id+" ;";
		stmt.executeUpdate(sql);
	}
		sql="delete from operate where id="+id+" and dates='"+gonedate+"'  ;";
		stmt.executeUpdate(sql);
	///////////////////////////////////////////////////////////////////////////////////////지우기 끝
	try{
		sql="insert into operate values('"+date+"',"+sleep+","+id+");";
		stmt.executeUpdate(sql);
		for(i=0;i<sleep;i++){
			sql="insert into book (dates,person,place,id) values('"+date+"'+ interval "+i+" day,"+person+",'"+place+"',"+id+");";
			stmt.executeUpdate(sql);
		}
	}catch(Exception e){
		out.println(e);
		return;
	}		
	
	
	stmt.close();
	conn.close();

%>
<script>
alert("<%=date%>부터   <%=sleep-1%>박 <%=sleep%>일 동안 <%=place%> 인원<%=person%>의 예약이 정상적으로 등록이 되었습니다.");
document.location="f_01.jsp";
</script>
</body>
</html>