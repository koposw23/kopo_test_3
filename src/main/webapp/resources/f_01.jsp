<%@page import="java.io.*, java.sql.*,javax.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
</head>
<body bgcolor ="#fff00">

<h1>주인장 예약자 리스트</h1>
<%	
	String type=request.getParameter("type");
	String content=request.getParameter("content");
	Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root", "koposw");
	Statement stmt =conn.createStatement();
	String sql=null;
/////////////////////////////////////////////////////////////////////////////////여기부터 페이지뷰 입력을 받을 곳		
	int LastLine=0;//목록 갯수를 파악하기 위한 변수 선언
	int LineCnt=0; //리스트 출력갯수 제한
	int PG=1; //리스트 1~10개가 담긴 페이지
	int PG_get=0; //리스트 1~10개가 담긴 페이지 
	String pg = request.getParameter("PG"); // 선택된 페이지 번호 참조
	if (pg == null) { //주소창에 f_01.jsp만 넣거나 제대로 PG변수를 입력 안 한 경우 null값이 들어가게 되는데 이때 대처법이다.
	pg = "1"; //문자열로 입력받게 된다.
	PG_get = Integer.parseInt(pg); //숫자로 변환한다.
	}
	else{
		PG_get = Integer.parseInt(pg); //아니면 말구
	}

	String gg = request.getParameter("GG"); //입력값을 주소창에서 받게 된다.
	int GG = 0; // PG가 1~10모인 것의 단위
	//GG는 리스트를 최대 10개씩 출력하는 페이지를 10개로 묶는 단위 즉, 1~100개의 리스트가 들어있다.
	if(gg == null){
		gg = "1";
		GG = Integer.parseInt(gg); 
	}
	else{
		GG = Integer.parseInt(gg); 
	}
/////////////////////////////////////////////////////////////////////////////////여기까지가 페이지뷰 입력을 받는 곳		
	ResultSet rset=null;
	try{if(type==null){
		sql="select count(*) from operate;";
		rset= stmt.executeQuery(sql);
		rset.next();
		LastLine= rset.getInt(1);//목록 갯수를 우선 파악
		sql="select distinct a.dates, a.sleep, a.id, b.place, b.person from operate a, book b where  a.id=b.id";
		
	}else if(type.equals("dates")){ //날짜로 검색
		sql="select count(*) from book where dates like '%"+content+"%';";
		rset= stmt.executeQuery(sql);
		rset.next();
		LastLine= rset.getInt(1);//목록 갯수를 우선 파악
		sql="select distinct a.dates, a.sleep, a.id, b.place, b.person from operate a, book b where b.id=a.id and a.dates like '%"+content+"%';";

	}else if(type.equals("id")){ //예약 id로 검색
			sql="select count(*) from book where id like '%"+content+"%';";
		rset= stmt.executeQuery(sql);
		rset.next();
		LastLine= rset.getInt(1);//목록 갯수를 우선 파악
		sql="select distinct a.dates, a.sleep, a.id, b.place, b.person from operate a, book b where  a.id=b.id and a.id like '%"+content+"%' ;";
	}else{ //방으로 검색
			sql="select count(id) from book where place like '%"+content+"%' ;";
		rset= stmt.executeQuery(sql);
		rset.next();
		LastLine= rset.getInt(1);//목록 갯수를 우선 파악
			sql="select distinct a.dates, a.sleep, a.id, b.place, b.person from operate a, book b where b.id=a.id and b.place like '%"+content+"%';";

	}
	rset =stmt.executeQuery( sql );
		
	
	/////////////////////////////////////////////////페이지뷰를 만들기 위한 준비작업
	int MGG = 0; //최대 GG의 갯수를 파악하려고 한다.	
	if(LastLine%100==0){  //100으로 나눈 페이지 수를 계산한다.
		MGG = LastLine/100;}
	else{
		MGG = LastLine/100+1;
	}
	int MG=0; //한 GG내에서 최대 PG범위 1~10

	if(GG<MGG){ // GG가 최대 GG를 넘지 않는 페이지 뷰에서는...
		MG=10;
	}
	else if(GG==MGG){ // GG가 최대 GG와 같을 경우 = 마지막 페이지가 있는 GG
		MG= ((LastLine/10)%10)+1;  //마지막 페이지인 PG(MG)는 0부터 시작되므로 1을 더한다. 
	}
%>
<table border="1">
<tr>
<td align=center>날짜</td><td align=center>숙박일</td><td align=center>회원id</td><td align=center >장소</td>
<td width=100px align=center>인원수</td>
</tr>
<%
int com=0;  // 마지막 페이지(GG의 마지막)를 보여주기 위한 변수 선언과 정의
	while(rset.next())
	{
		if(GG==MGG && MG < PG_get){com=MG;}
		else{com=PG_get;}
		if(LineCnt>(GG-1)*100+com*10) { //출력 리스트의 갯수가 10이상이면 그만 보여줌
			break;
		}
		if(LineCnt >= (GG-1)*100+(com-1)*10) {
%>
<tr><!--예약상황 리스트 출력부분-->
		<td align=center><%=rset.getString(1)%></td>
		<td align=center><%=rset.getInt(2)%></td>  
		<td align=center><a href="f_02.jsp?id=<%=rset.getInt(3)%>"><%=rset.getInt(3)%></td>
		<!- 회원 id별 내용으로 들어가서 삭제나 수정을 한다 ->
		<td align=center><%=rset.getString(4)%></td>
		<td align=center><%=rset.getInt(5)%></td>
		</td>
</tr>
<%		
	}
	else{}
	LineCnt++;
	}
	
		
	stmt.close();
	conn.close();
	rset.close();
%>	
</table>
<table><tr>
<form action="f_01.jsp">
<td align=right>
<select name="type"> <%--찾는 부분을 라디오 버튼으로 함, -% 이것은 jsp주석임 --%>
<option value="id" selected> 회원id </option> <!- 이것은 html 주석임 ->
<option value="place" >  장소  </option>
<option value="dates">날짜</option>
</select>	
<input type="text" name="content" value="" size=35 maxlength=50>
<input type=submit  value='찾기'></td>
</form>
</tr>
</table>
<%
	if(GG>1){
		
%>
<tr >
<th align = right width=400px><a href ="f_01.jsp?GG=<%=GG-1%>&PG=1" style="text-decoration:none !important">이전 10페이지</a></th>
<%		

}
else{
	%>
<tr>
<th align = right width=450px>prev</a></th>
<%
}
if(MG<PG_get){
	while(PG<MG){
	%>
	<td text-decoration: none><a  href ="f_01.jsp?PG=<%=PG%>&GG=<%=GG%>" style="text-decoration:none !important" ><%=PG%></a></td>
	<%
	PG = PG+1;
	}
	%>
	<td text-decoration: none><a  href ="f_01.jsp?PG=<%=PG%>&GG=<%=GG%>" ><%=PG%></a></td>
	<%
	PG = PG+1;
}
	else{
	while(PG<PG_get){
	%>
	<td text-decoration: none><a hover href ="f_01.jsp?PG=<%=PG%>&GG=<%=GG%>" style="text-decoration:none !important" ><%=PG%></a></td>
	<%
	PG = PG+1;
	}
	%>
	<td text-decoration: underline><a href ="f_01.jsp?PG=<%=PG_get%>&GG=<%=GG%>" ><%=PG_get%></a></td>
	<%
	PG = PG+1;
	while(PG<=MG){
	%>
	<td text-decoration: none><a  href ="f_01.jsp?PG=<%=PG%>&GG=<%=GG%>" style="text-decoration:none !important" ><%=PG%></a></td>
	<%
	PG = PG+1;
	}
}
if(GG<MGG){
%>
<th align = left width =200px><a href ="f_01.jsp?GG=<%=GG+1%>&PG=<%=MG%>" style="text-decoration:none !important">다음 10페이지</a></th>
</tr>
<%
		}
else{
	
	%>
<th align = left width =200px>next</a></th>
</tr>
</table>
<%
}
}catch(Exception e){
	out.print("<h2>"+e+"</h2>");
	}
%>
<table><tr>
<td align=right>

</tr>
</table>
</body>
</html>