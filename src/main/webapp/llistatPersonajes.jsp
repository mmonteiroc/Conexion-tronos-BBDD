<%@ page import="java.sql.*" %>
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


    // Si recibimos parametros por get
    String idBorrar = null;
    String queryBorrar = null;
    Statement statementBorrar = null;


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
        statement = connection.createStatement();


        idBorrar = request.getParameter("borrar");
        if (idBorrar != null) {
            statementBorrar = connection.createStatement();
            queryBorrar = "delete from characters where id=" + idBorrar;
            statementBorrar.executeUpdate(queryBorrar);
        }


        sentencia = "SELECT characters.name as nombre,house.name as casa, characters.id as personajeId FROM characters LEFT JOIN house ON characters.allegianceTo=house.id order by characters.name ";
        resultSet = statement.executeQuery(sentencia);


    } catch (Exception e) {
        e.printStackTrace();
    } finally {

    }

%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-16">
    <title>Llistat de usuaris</title>
    <link rel="stylesheet" href="css/general.css">

</head>
<body>
<header>
    <nav>
        <ul>
            <li><a href="formCharacter.jsp">Añadir Characters</a></li>
            <li><a href="llistatPersonajes.jsp">Listado de personajes</a></li>
            <li><a href="llistatCasas.jsp">Listado de Casas</a></li>
        </ul>
    </nav>

</header>

<table>
    <tr>
        <th>Nombre del personaje</th>
        <th>Nombre de la Casa</th>
        <th>Modificar dicho personaje</th>
        <th>Eliminar dicho personaje</th>
    </tr>


    <%
        try {
            while (resultSet.next()) {
                out.println("<tr>");
                out.println("<td>" + resultSet.getString("nombre") + "</td>"); // Col 1

                if (resultSet.getString("casa") == null) {
                    out.println("<td> </td>"); // Col 2
                } else {
                    out.println("<td>" + resultSet.getString("casa") + "</td>"); // Col 2
                }
                out.println("<td><form action=\"modificarPersonaje.jsp\" method=\"get\" ><button name=\"modificar\" value=\"" + resultSet.getInt("personajeId") + "\">Modificar</button></form></td>");
                out.println("<td><form action=\"llistatPersonajes.jsp\" method=\"get\"><button name=\"borrar\" value=\"" + resultSet.getInt("personajeId") + "\">Eliminar</button></form></td>"); // Col 3
                out.println("</tr>");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    %>
</table>


</body>
</html>


