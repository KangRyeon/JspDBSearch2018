<%@page contentType="text/html; charset=euc-kr" %>
<html>
<style>
        body {margin-top : 100px;}

</style>
<body><center>

        <h1> ����� �б޴� �л��� </h1>
        <form name='my_form' action='show.jsp' method='post'>
                <table border=1 width=500px>
                        <th>�� �Ⱓ </th>
                        <tr>
                                <td>
                                        <%
                                                String year[] = {"2010", "2011", "2013", "2014", "2015", "2016", "2017", "���"};

                                                out.println("<input type='checkbox' name='year_check' value='2010'/>"+year[0]);
                                                for(int i=1;i<7;i++){
                                                        out.println("<label><input type='checkbox' name='year_check' value='"+year[i]+"' />"+year[i]+"</label>");
                                                }
                                                out.println("<label><input type='checkbox' name='year_check' value='���' checked/>"+year[7]+"</label>");
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
                                        <label><input type='checkbox' name='year_check' value='���' checked />���</label>
-->
                                </td>
                        </tr>

                        <th>�� ���� </th>
                        <tr>
                                <td>
                                        <%
                                                String area[] = {"���α�", "�߱�", "��걸", "������", "������"
                                                                                        , "���빮��", "�߶���", "���ϱ�", "���ϱ�", "������"
                                                                                        , "�����", "����", "���빮��", "������", "��õ��"
                                                                                        , "������", "���α�", "��õ��", "��������", "���۱�"
                                                                                        , "���Ǳ�", "���ʱ�", "������", "���ı�", "������", "���"};
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
                                        <input type='checkbox' name='area_check' value='���α�' />���α�
                                        <label><input type='checkbox' name='area_check' value='�߱�' checked />�߱�</label>
                                        <label><input type='checkbox' name='area_check' value='��걸' />��걸</label>
                                        ...mm 
                                        <label><input type='checkbox' name='area_check' value='���' checked />���</label>
-->
                                </td>
                        </tr>

                        <th>�� �б� </th>
                        <tr>
                                <td>
                                        <input type='checkbox' name='school_check' value='k' />��ġ��
                                        <label><input type='checkbox' name='school_check' value='e' />�ʵ��б�</label>
                                        <label><input type='checkbox' name='school_check' value='m' />���б�</label>
                                        <label><input type='checkbox' name='school_check' value='h' />����б�</label>
                                        <label><input type='checkbox' name='school_check' value='���' checked/>���</label>
                                </td>
                        </tr>
                </table>
                <input type='submit' value="Ȯ��">
        </form>

</center></body>
</html>
