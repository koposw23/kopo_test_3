<%@page import="java.io.*, java.sql.*,javax.sql.*,java.util.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<script>
function ck(mode,id,goneplace,gonedates,goneperson,gonesleep){
	if(mode=="yes"){
		insert.action = "f_update_go.jsp?&gonedate="+gonedates+"&id="+id+"&goneplace="+goneplace+"&gonesleep="+gonesleep+"&goneperson="+goneperson; 
		insert.submit();		
	}else{
		insert.action="f_01.jsp";
		insert.submit();		
	}
		
}


</script>
</head>
<body>

<h1>펜션예약 수정</h1>
<%
	String ids = request.getParameter("id"); //  회원id	
	String persons = request.getParameter("person"); //  인원
	String dates = request.getParameter("dates"); //  날짜
	String sleeps = request.getParameter("sleep"); //  숙박일
	String place = new String(request.getParameter("place").getBytes("8859_1"),"utf-8");
	String k01=dates.substring(0,4);
	String k02=dates.substring(4,6);
	String k03=dates.substring(6,8);
	String date=dates; //이것은 수정된 것을 보낼 때 쓰일 날짜임
	dates=k01+"-"+k02+"-"+k03;

	out.println(ids+persons+date+sleeps+place);
	int id= Integer.parseInt(ids);
	int person= Integer.parseInt(persons);
	int sleep= Integer.parseInt(sleeps);
	
	//일단 내용을 보여준다.
	%>
<form method ='post' name='insert'>
<table border="1" cellpadding="1" cellspacing="0">
<tr>
<td align=center>회원id</td>
<td width=700px><input type="text" name="id" value="<%=id%>" hidden><%=id%></td>
</tr>
<tr>
<td align=center>장소</td>
<td width=700px><input type="text" name="place" value="<%=place%>"></td>
<br>
<td align=center>인원</td>
<td width=700px><input type="number" name="person" value="<%=person%>" size=120 maxlength=120></td>
<br>
<td align=center>시작날짜</td>
<td><input type="text" name="dates" value="20160703 형태로 입력하세요"></td>
<br>
<td align=center>숙박일</td>
<td><input type="number" name="sleep" value="<%=sleeps%>"></td>
<br>
<td  colspan=2 width=450px align=right><input type=button value="수정" OnClick="ck('yes','<%=id%>','<%=place%>','<%=date%>','<%=person%>','<%=sleeps%>')">
<input type=button value="취소" OnClick="ck('no',0,0,0,0,0)">
</tr>
</form>

<tr>
<form action="f_01.jsp">
<input type=submit value="취소">
</td></tr>
</table>
</form>


</body>
</html>