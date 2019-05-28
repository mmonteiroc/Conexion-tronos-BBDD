<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 25/05/19
  Time: 21:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    String nameCasa = "";
    Connection connection = null;
    Statement statement = null;
    String sentencia = "";



    // BBDD -- Variables
    private final String HOST_BBDD = "localhost";
    private final Integer PORT_BBDD = 3306;
    private final String NAME_BBDD = "GOT";
    private final String USER_BBDD = "gotAdmin";
    private final String PASSWORD_BBDD = "adminGot";
%>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
    } catch (Exception e) {
        e.printStackTrace();
    }
    nameCasa = request.getParameter("house-name");

    try {


        connection = DriverManager.getConnection("jdbc:mysql://"
                + HOST_BBDD + ":"
                + PORT_BBDD.toString() + "/"
                + NAME_BBDD + "?user="
                + USER_BBDD + "&password="
                + PASSWORD_BBDD);
        statement  = connection.createStatement();

        sentencia="insert into house (name) values (\""+nameCasa+"\")";
        statement.execute(sentencia);
        // resultSet = statement.executeQuery("select 1");


%>


<html>
<head>
    <title>Title</title>
</head>
<body>


<script>

    location.href = "llistatCasas.jsp";

</script>


</body>
</html>


<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>