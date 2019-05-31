<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %><%--
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
    String queryCasas = null;

    // Si recibimos parametros por get para borrar las casas
    String idBorrar = null;
    String queryBorrar = null;
    Statement statementBorrar = null;

    // buscar casas
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


        // queryCasas para sacar las casas
        statementTotales = connection.createStatement();
        nameBusqueda = request.getParameter("search");
        if (nameBusqueda == null) {
            queryCasas = "select name,id from house order by name";
        } else {
            queryCasas = "select name,id from house where name like '%" + nameBusqueda + "%' order by name";
        }
        resultadoTotales = statementTotales.executeQuery(queryCasas);


%>



<html>
<head>
    <meta charset="UTF-16">
    <title>Listado de casas</title>
    <link rel="stylesheet" href="css/listHouse.css">
</head>
<header>
    <nav>
        <ul>
            <li><a href="formCharacter.jsp">ADD Characters and Houses</a></li>
            <li><a href="llistatPersonajes.jsp">Listado de personajes</a></li>
            <li><a href="llistatCasas.jsp">Listado de Casas</a></li>
        </ul>
    </nav>

</header>
<body class="pepi">


<form action="llistatCasas.jsp" method="get" class="probando">
    <label for="search">Buscar casa</label>
    <input type="text" name="search" id="search" placeholder="Casa aria" value="<%

        if (nameBusqueda!=null){
            out.println(nameBusqueda);
        }

    %>">
    <input type="submit" id="boton-enviar" value="Buscar">
</form>

<div class="tabla-casas">

    <table>

        <tr>
            <th>
                Casas
            </th>
            <th>
                Modificar casa
            </th>
            <th>
                Eliminar casa
            </th>
        </tr>
        <%
            try {
                while (resultadoTotales.next()) {
                    out.println("<tr>");
                    out.println("<td>" + resultadoTotales.getString("name") + "</td>"); // Col 1
                    out.println("<td><form action=\"modificarCasa.jsp\" method=\"get\" ><button id=\"boton-enviar\" name=\"modificar\" value=\"" + resultadoTotales.getInt("id") + "\">Modificar</button></form></td>"); // Col2
                    out.println("<td><form action=\"llistatCasas.jsp\" method=\"get\"><button id=\"boton-enviar\" name=\"borrar\" value=\"" + resultadoTotales.getInt("id") + "\">Eliminar</button></form></td>"); // Col 3
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
            //if (connection != null) connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>