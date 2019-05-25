<%@ page import="jdk.nashorn.internal.runtime.ECMAException" %>
<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 24/05/19
  Time: 18:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    String name = "";
    Integer idCasa = null;
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    String sentencia = "";



    // BBDD -- Variables
    private final String HOST_BBDD = "localhost";
    private final Integer PORT_BBDD = 3306;
    private final String NAME_BBDD = "GOT";
    private final String USER_BBDD = "miguel";
    private final String PASSWORD_BBDD = "monteiro";
%>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();
    } catch (Exception e) {
        e.printStackTrace();
    }
    name = request.getParameter("name");
    idCasa = Integer.parseInt(request.getParameter("casa"));

    try {



        connection = DriverManager.getConnection("jdbc:mysql://"
                + HOST_BBDD + ":"
                + PORT_BBDD.toString() + "/"
                + NAME_BBDD + "?user="
                + USER_BBDD + "&password="
                + PASSWORD_BBDD);
        statement  = connection.createStatement();

        sentencia="insert into characters (name,allegianceTo) values (\""+name+"\","+idCasa+")";
        statement.execute(sentencia);
        // resultSet = statement.executeQuery("select 1");


    } catch (SQLException e) {
        e.printStackTrace();
    }





%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>insertar</title>
</head>
<body>




<p>
<%=name%>
<%=idCasa%>
<%=sentencia%>

</p>


<script>

    setInterval(function () {
        location.href ="llistat.jsp";
    },500);

</script>

</body>
</html>
