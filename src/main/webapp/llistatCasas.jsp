<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 27/05/19
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!

    Connection connection = null;
    Statement statementTotales = null;
    ResultSet resultadoTotales = null;
    String queryCasasTotal = null;


    // Si recibimos parametros por get para borrar las casas
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


        idBorrar = request.getParameter("borrar");
        if (idBorrar != null) {
            statementBorrar = connection.createStatement();
            Statement safeUpdates0 = connection.createStatement();
            Statement safeUpdates1 = connection.createStatement();
            Statement borrarReferencias = connection.createStatement();
            safeUpdates0.execute("SET SQL_SAFE_UPDATES = 0");
            borrarReferencias.executeUpdate("update characters set allegianceTo = null where allegianceTo=" + idBorrar);
            safeUpdates1.execute("SET SQL_SAFE_UPDATES = 1");


            queryBorrar = "delete from house where id=" + idBorrar;
            statementBorrar.executeUpdate(queryBorrar);
        }


        // queryCasas para todas las casas
        statementTotales = connection.createStatement();
        queryCasasTotal = "select name,house.id from house;";
        resultadoTotales = statementTotales.executeQuery(queryCasasTotal);


    } catch (Exception e) {
        e.printStackTrace();
    }


%>


<html>
<head>
    <meta charset="UTF-16">
    <title>Listado de casas</title>
    <link rel="stylesheet" href="css/general.css">
</head>
<header>
    <nav>
        <ul>
            <li><a href="formCharacter.jsp">Añadir Characters</a></li>
            <li><a href="llistatPersonajes.jsp">Listado de personajes</a></li>
            <li><a href="llistatCasas.jsp">Listado de Casas</a></li>
        </ul>
    </nav>

</header>
<body>


<table>

    <tr>
        <th>
            Todas las casas existentes
        </th>
        <th>
            Eliminar dicha casa
        </th>
    </tr>
    <%
        try {
            while (resultadoTotales.next()) {
                out.println("<tr>");
                out.println("<td>" + resultadoTotales.getString("name") + "</td>"); // Col 1
                out.println("<td><form action=\"llistatCasas.jsp\" method=\"get\"><button name=\"borrar\" value=\"" + resultadoTotales.getInt("id") + "\">Eliminar</button></form></td>"); // Col 2
                out.println("</tr>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>


</table>


</body>
</html>
