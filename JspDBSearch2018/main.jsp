<%@page contentType="text/html; charset=euc-kr" %>
<html>
<style>
        body {margin-top : 100px;}

</style>
<body><center>

        <h1> 서울시 학급당 학생수 </h1>
        <form name='my_form' action='show.jsp' method='post'>
                <table border=1 width=500px>
                        <th>※ 기간 </th>
                        <tr>
                                <td>
                                        <%
                                                String year[] = {"2010", "2011", "2013", "2014", "2015", "2016", "2017", "모두"};

                                                out.println("<input type='checkbox' name='year_check' value='2010'/>"+year[0]);
                                                for(int i=1;i<7;i++){
                                                        out.println("<label><input type='checkbox' name='year_check' value='"+year[i]+"' />"+year[i]+"</label>");
                                                }
                                                out.println("<label><input type='checkbox' name='year_check' value='모두' checked/>"+year[7]+"</label>");
                                        %>
<!--
                                        <input type='checkbox' name='year_check' value='2010' />2010
                                        <label><input type='checkbox' name='year_check' value='2011' />2011</label>
                                        <label><input type='checkbox' name='year_check' value='2012' />2013</label>
                                        <label><input type='checkbox' name='year_check' value='2013' />2013</label>
                                        <label><input type='checkbox' name='year_check' value='2014' />2014</label>
                                        <label><input type='checkbox' name='year_check' value='2015' />2015</label>
                                        <label><input type='checkbox' name='year_check' value='2016' />2016</label>
                                        <label><input type='checkbox' name='year_check' value='2017' />2017</label>
                                        <label><input type='checkbox' name='year_check' value='모두' checked />모두</label>
-->
                                </td>
                        </tr>

                        <th>※ 지역 </th>
                        <tr>
                                <td>
                                        <%
                                                String area[] = {"종로구", "중구", "용산구", "성동구", "광진구"
                                                                                        , "동대문구", "중랑구", "성북구", "강북구", "도봉구"
                                                                                        , "노원구", "은평구", "서대문구", "마포구", "양천구"
                                                                                        , "강서구", "구로구", "금천구", "영등포구", "동작구"
                                                                                        , "관악구", "서초구", "강남구", "송파구", "강동구", "모두"};
                                        %>
                                        <table>
                                                <tr><td>
                                                        <%
                                                                for(int i=0;i<25;i++){
                                                                        out.println("<td>");
                                                                        if(i==0)
                                                                                out.println("<input type='checkbox' name='area_check' value='"+area[i]+"'/>"+area[0]);
                                                                        else
                                                                                out.println("<label><input type='checkbox' name='area_check' value='"+area[i]+"' />"+area[i]+"</label>");
                                                                        out.println("</td>");
                                                                        if(i%5 == 0 && i != 0)
                                                                                out.println("</td></tr><tr><td>");
                                                                }
                                                                out.println("<td>");
                                                                out.println("<label><input type='checkbox' name='area_check' value='"+area[25]+"' checked/>"+area[25]+"</label>");
                                                                out.println("</td>");
                                                        %>
                                                        </td>
                                                </tr>
                                        </table>
<!--
                                        <input type='checkbox' name='area_check' value='종로구' />종로구
                                        <label><input type='checkbox' name='area_check' value='중구' checked />중구</label>
                                        <label><input type='checkbox' name='area_check' value='용산구' />용산구</label>
                                        ...mm 
                                        <label><input type='checkbox' name='area_check' value='모두' checked />모두</label>
-->
                                </td>
                        </tr>

                        <th>※ 학교 </th>
                        <tr>
                                <td>
                                        <input type='checkbox' name='school_check' value='k' />유치원
                                        <label><input type='checkbox' name='school_check' value='e' />초등학교</label>
                                        <label><input type='checkbox' name='school_check' value='m' />중학교</label>
                                        <label><input type='checkbox' name='school_check' value='h' />고등학교</label>
                                        <label><input type='checkbox' name='school_check' value='모두' checked/>모두</label>
                                </td>
                        </tr>
                </table>
                <input type='submit' value="확인">
        </form>

</center></body>
</html>
