<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="jdk.nashorn.internal.runtime.ECMAException" %><%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 24/05/19
  Time: 18:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    String name = "";
    String house = "";
    Connection conexion = null;
    Statement statement = null;
    String query = "";

    String host = "localhost";
    Integer port = 3306;
    String bbdd = "GOT";
    String USER_BBDD = "root";
    String PASSWORD_BBDD = "Papymamy13";

%>

<%
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    name = request.getParameter("name");

    try {
        conexion = DriverManager.getConnection("jdbc:mysql://"
                + host + ":"
                + port.toString() + "/"
                + bbdd + "?user="
                + USER_BBDD + "&password="
                + PASSWORD_BBDD);

        statement = conexion.createStatement();
    } catch (SQLException e) {
        e.printStackTrace();
    }


%>

<html>
<head>
    <title>insertar</title>
</head>
<body>




<p>
<%=name%>
</p>


</body>
</html>
