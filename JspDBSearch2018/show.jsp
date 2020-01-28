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
         // �Ķ���� ����.
        String[] year = null, area = null, school = null;
        year = request.getParameterValues("year_check");                // �⵵
        area = request.getParameterValues("area_check");                // ����
        school = request.getParameterValues("school_check");    // �б�


        if(year != null){
                out.println("<br>�⵵ :");
                for (int i=0; i< year.length; i++){
                        out.println(year[i]+" ");
                }
        }

        if(area != null){
                out.println("</br>���� : ");
                for (int i=0; i< area.length; i++){
                        out.println(area[i]+" ");
                }
        }

        if(school != null){
                out.println("</br>�б� : ");
                for (int i=0; i< school.length; i++){
                        out.println(school[i]+" ");
                }
                out.println("</br>");
        }
        %>
        <%
                // db����
                String URL = "jdbc:mysql://localhost:3306/yourDBname";
                String USER = "yourDBname";
                String PASS = "0000";
                Connection conn=null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                String searchY[] = new String[10];                                      // searchY == �˻��� �Ⱓ
                int searchYN = 0;
                String searchA[] = new String[30];                                      // searchA == �˻��� ����
                int searchAN = 0;
                String searchS[] = new String[5];                                       // searchS == �˻����б�
                int searchSN = 0;

                try {
                        Class.forName("com.mysql.jdbc.Driver");         // mysql ���
                        conn = DriverManager.getConnection(URL, USER, PASS);    // ���̵�, ��й�ȣ, �ּ� �ְ� ����

//                      out.println("year : "+year[0].equals("���")+", area : "+area[0].equals("���")+", school : "+school[0].equals("���"));
                        String sql = "select ";

                        String select[] = new String[15];
                        int selectN = 0;

                        if(school != null && school[0].equals("���") != true){                               // �б����� ���� ����ٸ�, ��ΰ� �ƴ϶��
                                sql += "year, area";
                                select[selectN++] = "�Ⱓ";
                                select[selectN++] = "����";

                                String schoolName = "";
                                for(int i=0; i<school.length; i++){
                                        if(school[i].equals("k")){
                                                sql += ", k_total, k_class, k_perclass ";
                                                schoolName = "��ġ��";
                                                searchS[searchSN++] = "��ġ��";
                                        }
                                        if(school[i].equals("e")){
                                                sql += ", e_total, e_class, e_perclass ";
                                                schoolName = "�ʵ��б�";
                                                searchS[searchSN++] = "�ʵ��б�";
                                        }
                                        if(school[i].equals("m")){
                                                sql += ", m_total, m_class, m_perclass ";
                                                schoolName = "���б�";
                                                searchS[searchSN++] = "���б�";
                                        }
                                        if(school[i].equals("h")){
                                                sql += ", h_total, h_class, h_perclass ";
                                                schoolName = "����б�";
                                                searchS[searchSN++] = "����б�";
                                        }
                                        select[selectN++] = schoolName+"�л���";
                                        select[selectN++] = schoolName+"�б޼�";
                                        select[selectN++] = schoolName+"�б޴��л���";
                                }

                        }
                        else{
                                sql += "* ";
                                selectN = 14;
                                String s[] = {"�Ⱓ", "����", "��ġ���л���", "��ġ���б޼�", "��ġ���б޴��л���"
                                                                , "�ʵ��б��л���", "�ʵ��б��б޼�", "�ʵ��б��б޴��л���"
                                                                , "���б��л���", "���б��б޼�", "���б��б޴��л���"
                                                                , "����б��л���", "����б��б޼�", "����б��б޴��л���"};
                                for(int i=0;i<s.length;i++)
                                        select[i] = s[i];
                                searchS[searchSN++] = "���";
                        }

//                      out.println("selectN = "+selectN+"</br>");
                        sql += "from student_count ";

                        if(year != null && area != null && school != null && year[0].equals("���")!=true || area[0].equals("���")!=true)      // area[0].equlas("���") ������ true, �ƴϸ� false
                                sql += "where ";                                                                                                                                                                                                 -                                                                                                        // �� ��ζ�� �Ƚ���.

                        if(year != null && year[0].equals("���") != true){                               // �⵵���� ���� ����ٸ�, ��ΰ� �ƴ϶��

                                for(int i=0; i<year.length; i++){
                                        if(i == 0)                                      // i==0 �̸� �տ� or�� �������
                                                sql += "(year='"+year[i]+"' ";
                                        if(i != 0)                                      // i!=0 �̸� �տ� or�� �־����.
                                                sql += "or year='"+year[i]+"' ";
                                        searchY[searchYN++] = year[i];
                                }
                                sql += ") ";
                        }
                        else
                                searchY[searchYN++] = "���";

                        if(area != null && area[0].equals("���") != true){                               // �������� ���� ����ٸ�, ��ΰ� �ƴ϶��

                                if(year != null && year[0].equals("���")!=true)                        // �ٸ��͵鵵 ���� ���� �ִٸ�
                                        sql += "and ";                                  // ���۹��� and �־����.
                                for(int i=0; i<area.length; i++){
                                        if(i == 0)                                      // i==0 �̸� �տ� or�� �������
                                                sql += "(area='"+area[i]+"' ";
                                        if(i != 0)                                      // i!=0 �̸� �տ� or�� �־����.
                                                sql += "or area='"+area[i]+"' ";
                                        searchA[searchAN++] = area[i];
                                }
                                sql += ") ";
                        }
                        else
                                searchA[searchAN++] = "���";


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

                        // �˻��� ��� �����
                        String ip = request.getRemoteAddr();
                        String searchY2 = "";
//                      out.println("�˻��� �Ⱓ : ");
                        for(int i=0;i<searchYN;i++){
//                              out.println(searchY[i]+", ");
                                searchY2 += searchY[i]+" ";
                        }

                        String searchA2 = "";
//                      out.println("<br>�˻��� ���� : ");
                        for(int i=0;i<searchAN;i++){
//                              out.println(searchA[i]+", ");
                                searchA2 += searchA[i]+" ";
                        }

                        String searchS2 = "";
//                      out.println("<br>�˻��� �б� : ");
                        for(int i=0;i<searchSN;i++){
//                              out.println(searchS[i]+", ");
                                searchS2 += searchS[i]+" ";
                        }

//                      out.println("<br>"+searchY2 +", "+ searchA2 + ", "+ searchS2+"<br>");
                        sql = "insert into searcher values('"+ip+"', '"+searchY2+"', '"+searchA2+"', '"+searchS2+"')";

//                      out.println("sql : "+ sql+"<br>");
                        pstmt = conn.prepareStatement(sql);
//                      int n = pstmt.executeUpdate();

                        // �˻��� ��� ����
                        sql = "select * from searcher";
                        pstmt = conn.prepareStatement(sql);
                        rs = pstmt.executeQuery();

                        out.println("<table border='1'>");
                        out.println("<th>�˻��� IP</th><th>�˻��� �Ⱓ</th><th>�˻��� ����</th><th>�˻��� �б�</th>");
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
