<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.sql.Statement" %><%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 24/05/19
  Time: 18:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    String name = "";
    Connection conexion = null;
    Statement statement = null;
%>

<%
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    name = request.getParameter("name");
    try {
        conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306//GOT/root/Papymamy13");
    } catch (SQLException e) {
        e.printStackTrace();
    }

    try {
        statement = conexion.createStatement();
        statement.executeUpdate("insert into ");
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

<html>
<head>
    <title>insertar</title>
</head>
<body>

    <h2><%=name%></h2>
</body>
</html>
