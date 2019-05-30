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
    private final String USER_BBDD = "gotAdmin";
    private final String PASSWORD_BBDD = "adminGot";
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
        queryCasasTotal = "select name,id from house order by name";
        resultadoTotales = statementTotales.executeQuery(queryCasasTotal);


%>


<html>
<head>
    <meta charset="UTF-16">
    <title>Casas</title>
    <link rel="stylesheet" href="css/listHouse.css">
</head>

<body class="listar-cas">

<header>
    <nav>
        <ul>
            <li><a href="formCharacter.jsp">Añadir Characters / Casas</a></li>
            <li><a href="llistatPersonajes.jsp">Listado de personajes</a></li>
            <li><a href="llistatCasas.jsp">Listado de Casas</a></li>
        </ul>
    </nav>

</header>
<div class="tabla-casas">

<table>

    <tr>
        <th>
            Casas
        </th>
        <th>
            Modificar
        </th>
        <th>
            Borrar
        </th>
    </tr>
    <%
        try {
            while (resultadoTotales.next()) {
                out.println("<tr>");
                out.println("<td>" + resultadoTotales.getString("name") + "</td>"); // Col 1
                out.println("<td><form action=\"modificarCasa.jsp\" method=\"get\" ><button id= \"boton-enviar\" name=\"modificar\" value=\"" + resultadoTotales.getInt("id") + "\">Modificar</button></form></td>"); // Col2
                out.println("<td><form action=\"llistatCasas.jsp\" method=\"get\"><button id= \"boton-enviar\" name=\"borrar\" value=\"" + resultadoTotales.getInt("id") + "\">Eliminar</button></form></td>"); // Col 3
                out.println("</tr>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>


</table>
</div>

</body>
</html>


<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {

            if (resultadoTotales != null) resultadoTotales.close();
            if (statementTotales != null) statementTotales.close();
            //if (statementBusqueda!=null) statementBusqueda.close();
            if (statementBorrar != null) statementBorrar.close();
            if (connection != null) connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>