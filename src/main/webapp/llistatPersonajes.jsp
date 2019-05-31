<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="java.util.List" %>
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

    // buscar personajes
    String nameBusqueda = null;


    // BBDD -- Variables
    private final String HOST_BBDD = "jdbc:mysql://localhost:3306";
    private final String NAME_BBDD = "GOT";
    private final String USER_BBDD = "gotAdmin";
    private final String PASSWORD_BBDD = "adminGot";
    // Pool
    final BasicDataSource pool = new BasicDataSource();



%>

<%

    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();

        // Conexion
        pool.setDefaultCatalog(NAME_BBDD);
        pool.setUsername(USER_BBDD);
        pool.setPassword(PASSWORD_BBDD);
        pool.setUrl(HOST_BBDD);

        // Parametros
        pool.setMaxIdle(10);
        pool.setMinIdle(1);
        pool.setMaxTotal(5);
        pool.setValidationQuery("select 1");
        pool.setValidationQueryTimeout(1);
        pool.setDefaultQueryTimeout(15);
        pool.setMaxWaitMillis(2000);


    } catch (Exception e) {
        e.printStackTrace();
    }

    try {

        /*connection = DriverManager.getConnection("jdbc:mysql://"
                + HOST_BBDD + ":"
                + PORT_BBDD.toString() + "/"
                + NAME_BBDD + "?user="
                + USER_BBDD + "&password="
                + PASSWORD_BBDD);*/

        connection = pool.getConnection();
        statement = connection.createStatement();

        // si recibimos un id de un personaje
        idBorrar = request.getParameter("borrar");
        if (idBorrar != null) {
            statementBorrar = connection.createStatement();
            queryBorrar = "delete from characters where id=" + idBorrar;
            statementBorrar.executeUpdate(queryBorrar);
        }


        nameBusqueda = request.getParameter("search");
        if (nameBusqueda == null) {
            sentencia = "SELECT characters.name as nombre,house.name as casa, characters.id as personajeId FROM characters LEFT JOIN house ON characters.allegianceTo=house.id order by characters.name ";
        } else {
            sentencia = "SELECT characters.name as nombre,house.name as casa, characters.id as personajeId FROM characters LEFT JOIN house ON characters.allegianceTo=house.id where characters.name like '%" + nameBusqueda + "%' order by characters.name ";
        }
        resultSet = statement.executeQuery(sentencia);


%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-16">
    <title>Llistat de usuaris</title>
    <link rel="stylesheet" href="css/listHouse.css">

</head>
<body class="pepi">
<header>
    <nav>
        <ul>
            <li><a href="formCharacter.jsp">ADD Characters and Houses</a></li>
            <li><a href="llistatPersonajes.jsp">Listado de personajes</a></li>
            <li><a href="llistatCasas.jsp">Listado de Casas</a></li>
        </ul>
    </nav>

</header>


<form action="llistatPersonajes.jsp" method="get" class="probando">
    <label for="search">Buscar personaje</label>
    <input type="text" name="search" id="search" placeholder="Capitan" value="<%

        if (nameBusqueda!=null){
            out.println(nameBusqueda);
        }

    %>">
    <input type="submit" id="boton-enviar" value="Buscar">
</form>


<div class="tabla-casas">

    <table>
        <tr>
            <th>Nombre Personaje</th>
            <th>Nombre Casa</th>
            <th>Modificar</th>
            <th>Eliminar</th>
        </tr>


        <%
            try {
                while (resultSet.next()) {
                    out.println("<tr class=\"filas\">");
                    out.println("<td>" + resultSet.getString("nombre") + "</td>"); // Col 1

                    if (resultSet.getString("casa") == null) {
                        out.println("<td> </td>"); // Col 2
                    } else {
                        out.println("<td>" + resultSet.getString("casa") + "</td>"); // Col 2
                    }
                    out.println("<td><form action=\"modificarPersonaje.jsp\" method=\"get\" ><button id= \"boton-enviar\" name=\"modificar\" value=\"" + resultSet.getInt("personajeId") + "\">Modificar</button></form></td>");
                    out.println("<td><form action=\"llistatPersonajes.jsp\" method=\"get\"><button id= \"boton-enviar\" name=\"borrar\" value=\"" + resultSet.getInt("personajeId") + "\">Eliminar</button></form></td>"); // Col 3
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
        // Aqui tendremos que cerrar la conexion
        try {

            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (statementBorrar != null) statementBorrar.close();
            if (connection != null) connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>