<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.DriverManager" %>
<%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 24/05/19
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!

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

    try {

        connection = DriverManager.getConnection("jdbc:mysql://"
                + HOST_BBDD + ":"
                + PORT_BBDD.toString() + "/"
                + NAME_BBDD + "?user="
                + USER_BBDD + "&password="
                + PASSWORD_BBDD);
        statement  = connection.createStatement();

        sentencia="SELECT characters.name as nombre,house.name as casa FROM characters INNER JOIN house ON characters.allegianceTo=house.id";
        resultSet = statement.executeQuery(sentencia);


    } catch (Exception e) {
        e.printStackTrace();
    }

%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Llistat de usuaris</title>
</head>
<body>

<nav>
    <ul>
        <li><a href="formCharacter.jsp">Añadir Characters</a></li>
        <li><a href="llistat.jsp">Listado de personajes/casas</a></li>
    </ul>
</nav>


    <%
        try{
            while (resultSet.next()){
            %>
    <h2>
    <%
                out.println(resultSet.getString("nombre"));

                out.println(resultSet.getString("casa"));
    %>
    </h2>
    <%

            }

        }catch (Exception e){
            e.printStackTrace();
        }
    %>




</body>
</html>


