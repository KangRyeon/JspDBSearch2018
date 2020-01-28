<%@page contentType="text/html; charset=euc-kr" %>
<%@page import="java.sql.*" %>
<html>
<head>
    <meta charset="utf-8">
    <title>Bootstrap Part5</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
</head>
<style>
        body {margin-top : 100px;}
        table {margin : 100px;}
</style>
<body><center>
<%
        request.setCharacterEncoding("euc-kr");
         // 파라미터 받음.
        String[] year = null, area = null, school = null;
        year = request.getParameterValues("year_check");                // 년도
        area = request.getParameterValues("area_check");                // 지역
        school = request.getParameterValues("school_check");    // 학교


        if(year != null){
                out.println("<br>년도 :");
                for (int i=0; i< year.length; i++){
                        out.println(year[i]+" ");
                }
        }

        if(area != null){
                out.println("</br>지역 : ");
                for (int i=0; i< area.length; i++){
                        out.println(area[i]+" ");
                }
        }

        if(school != null){
                out.println("</br>학교 : ");
                for (int i=0; i< school.length; i++){
                        out.println(school[i]+" ");
                }
                out.println("</br>");
        }
        %>
        <%
                // db연결
                String URL = "jdbc:mysql://localhost:3306/yourDBname";
                String USER = "yourDBname";
                String PASS = "0000";
                Connection conn=null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                String searchY[] = new String[10];                                      // searchY == 검색한 기간
                int searchYN = 0;
                String searchA[] = new String[30];                                      // searchA == 검색한 지역
                int searchAN = 0;
                String searchS[] = new String[5];                                       // searchS == 검색한학교
                int searchSN = 0;

                try {
                        Class.forName("com.mysql.jdbc.Driver");         // mysql 사용
                        conn = DriverManager.getConnection(URL, USER, PASS);    // 아이디, 비밀번호, 주소 넣고 연결

//                      out.println("year : "+year[0].equals("모두")+", area : "+area[0].equals("모두")+", school : "+school[0].equals("모두"));
                        String sql = "select ";

                        String select[] = new String[15];
                        int selectN = 0;

                        if(school != null && school[0].equals("모두") != true){                               // 학교에서 무언갈 골랐다면, 모두가 아니라면
                                sql += "year, area";
                                select[selectN++] = "기간";
                                select[selectN++] = "지역";

                                String schoolName = "";
                                for(int i=0; i<school.length; i++){
                                        if(school[i].equals("k")){
                                                sql += ", k_total, k_class, k_perclass ";
                                                schoolName = "유치원";
                                                searchS[searchSN++] = "유치원";
                                        }
                                        if(school[i].equals("e")){
                                                sql += ", e_total, e_class, e_perclass ";
                                                schoolName = "초등학교";
                                                searchS[searchSN++] = "초등학교";
                                        }
                                        if(school[i].equals("m")){
                                                sql += ", m_total, m_class, m_perclass ";
                                                schoolName = "중학교";
                                                searchS[searchSN++] = "중학교";
                                        }
                                        if(school[i].equals("h")){
                                                sql += ", h_total, h_class, h_perclass ";
                                                schoolName = "고등학교";
                                                searchS[searchSN++] = "고등학교";
                                        }
                                        select[selectN++] = schoolName+"학생수";
                                        select[selectN++] = schoolName+"학급수";
                                        select[selectN++] = schoolName+"학급당학생수";
                                }

                        }
                        else{
                                sql += "* ";
                                selectN = 14;
                                String s[] = {"기간", "지역", "유치원학생수", "유치원학급수", "유치원학급당학생수"
                                                                , "초등학교학생수", "초등학교학급수", "초등학교학급당학생수"
                                                                , "중학교학생수", "중학교학급수", "중학교학급당학생수"
                                                                , "고등학교학생수", "고등학교학급수", "고등학교학급당학생수"};
                                for(int i=0;i<s.length;i++)
                                        select[i] = s[i];
                                searchS[searchSN++] = "모두";
                        }

//                      out.println("selectN = "+selectN+"</br>");
                        sql += "from student_count ";

                        if(year != null && area != null && school != null && year[0].equals("모두")!=true || area[0].equals("모두")!=true)      // area[0].equlas("모두") 맞으면 true, 아니면 false
                                sql += "where ";                                                                                                                                                                                                 -                                                                                                        // 다 모두라면 안써줌.

                        if(year != null && year[0].equals("모두") != true){                               // 년도에서 무언갈 골랐다면, 모두가 아니라면

                                for(int i=0; i<year.length; i++){
                                        if(i == 0)                                      // i==0 이면 앞에 or이 없어야함
                                                sql += "(year='"+year[i]+"' ";
                                        if(i != 0)                                      // i!=0 이면 앞에 or이 있어야함.
                                                sql += "or year='"+year[i]+"' ";
                                        searchY[searchYN++] = year[i];
                                }
                                sql += ") ";
                        }
                        else
                                searchY[searchYN++] = "모두";

                        if(area != null && area[0].equals("모두") != true){                               // 지역에서 무언갈 골랐다면, 모두가 아니라면

                                if(year != null && year[0].equals("모두")!=true)                        // 다른것들도 무언가 값이 있다면
                                        sql += "and ";                                  // 시작문에 and 넣어야함.
                                for(int i=0; i<area.length; i++){
                                        if(i == 0)                                      // i==0 이면 앞에 or이 없어야함
                                                sql += "(area='"+area[i]+"' ";
                                        if(i != 0)                                      // i!=0 이면 앞에 or이 있어야함.
                                                sql += "or area='"+area[i]+"' ";
                                        searchA[searchAN++] = area[i];
                                }
                                sql += ") ";
                        }
                        else
                                searchA[searchAN++] = "모두";


//                      out.println("sql : "+sql+"<br>");

                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();

                        out.println("<table border='1' class='table'>");
                        for(int i=0;i<selectN;i++)
                                out.println("<th>"+select[i]+"</th>");

                        while(rs.next()){
                                out.println("<tr>");
                                for(int i=1; i<=selectN; i++){
                                        out.println("<td>");
                                        out.println(rs.getString(i)+"\t");
                                        out.println("</td>");
                                }
                                out.println("</tr>");
                        }
                        out.println("</table>");
                        out.println("\n");

                        // 검색어 기록 남기기
                        String ip = request.getRemoteAddr();
                        String searchY2 = "";
//                      out.println("검색한 기간 : ");
                        for(int i=0;i<searchYN;i++){
//                              out.println(searchY[i]+", ");
                                searchY2 += searchY[i]+" ";
                        }

                        String searchA2 = "";
//                      out.println("<br>검색한 지역 : ");
                        for(int i=0;i<searchAN;i++){
//                              out.println(searchA[i]+", ");
                                searchA2 += searchA[i]+" ";
                        }

                        String searchS2 = "";
//                      out.println("<br>검색한 학교 : ");
                        for(int i=0;i<searchSN;i++){
//                              out.println(searchS[i]+", ");
                                searchS2 += searchS[i]+" ";
                        }

//                      out.println("<br>"+searchY2 +", "+ searchA2 + ", "+ searchS2+"<br>");
                        sql = "insert into searcher values('"+ip+"', '"+searchY2+"', '"+searchA2+"', '"+searchS2+"')";

//                      out.println("sql : "+ sql+"<br>");
                        pstmt = conn.prepareStatement(sql);
//                      int n = pstmt.executeUpdate();

                        // 검색어 기록 보기
                        sql = "select * from searcher";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();

                        out.println("<table border='1'>");
                        out.println("<th>검색한 IP</th><th>검색한 기간</th><th>검색한 지역</th><th>검색한 학교</th>");
                        while(rs.next()){
                                out.println("<tr>");
                                for(int i=1; i<=4; i++){
                                        out.println("<td>");
                                        out.println(rs.getString(i)+"\t");
                                        out.println("</td>");
                                }
                                out.println("</tr>");
                        }
                        out.println("</table>");

                } catch(SQLException e){
                        out.println("1. "+e.getMessage()+"<br>");
                } finally {
                        if(rs != null)
                                rs.close();
                        if(pstmt != null)
                                pstmt.close();
                        if(conn != null)
                                conn.close();
                }

%>




</center></body>
</html>
