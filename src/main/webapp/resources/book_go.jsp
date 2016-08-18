<%@page import="java.io.*, java.sql.*,javax.sql.*"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
</head>
<body>

<h1>펜션예약</h1> <!- operate은 날짜계산 테이블 book은 예약완료된 테이블 ->
<%
   String date = request.getParameter("date"); //  회원이 입력한 숙박시작날짜   
   String sleeps = request.getParameter("sleep"); //  숙박기간
   String persons = request.getParameter("person"); //  인원수
   String place =new String( request.getParameter("place").getBytes("8859_1"),"utf-8"); //  장소 
   String ids = request.getParameter("id"); //  회원번호
   String k01=date.substring(0,4);
   String k02=date.substring(4,6);
   String k03=date.substring(6,8);
   date=k01+"-"+k02+"-"+k03; //날짜를 받아올 때 '-'가 안되서 숫자를 입력받아 다시 붙임
   

   if(date.length()<=0 ||sleeps.length()<=0 ||persons.length()<=0 ||ids.length()<=0){
   %>
   
   <script>
   alert("입력사항이 부족합니다.");
   document.location="main.htm";
   </script>
   <%
   return;
   }

   
   int sleep= Integer.parseInt(sleeps);
   int person= Integer.parseInt(persons);
   int id= Integer.parseInt(ids);
   int i=0,k=0;
   String [] gone=new   String[sleep];
   
   out.println(place+"ㅊ"+id);
   Class.forName("com.mysql.jdbc.Driver");
   Connection conn = DriverManager.getConnection("jdbc:mysql://192.168.23.111:33060/koposw23", "root", "koposw");
   Statement stmt =conn.createStatement();
   String sql="";
   ResultSet rset=null;
   try{   //새로 예약을 입력받기를 시도한다.
      sql="insert into operate values('"+date+"',"+sleep+","+id+");";//숙박날짜계산 테이블에 자료를 우선 넣는다.
      stmt.executeUpdate(sql);
      for(i=0;i<sleep;i++,k++){
         
         sql="insert into book (dates,person,place,id) values('"+date+"'+ interval "+i+" day,"+person+",'"+place+"',"+id+");";
         stmt.executeUpdate(sql);//예약테이블에 자료를 넣는다.

      }
   }catch(Exception e){
   
   for(i=0;i<k;i++){ //숙박기간을 예약테이블에서 지운다.
   
      sql="delete from book where place='"+place+"' and dates='"+date+"' + interval "+i+" day ;";
      stmt.executeUpdate(sql);
   }
   
   sql="delete from operate where id="+id+" and dates='"+date+"';";
   stmt.executeUpdate( sql );
      %>
      <script>
      alert("뭔가가 잘못되었습니다.<%=e%>");
      document.location="main.htm";
      </script>
      <%
   }      
   
   
   stmt.close();
   conn.close();

%>
<script>
alert("<%=date%>부터 <%=sleep-1%>박 <%=sleep%>일 동안 <%=place%> 인원<%=person%>의 예약이 정상적으로 등록이 되었습니다.");
document.location="main.htm";
</script>
</body>
</html>