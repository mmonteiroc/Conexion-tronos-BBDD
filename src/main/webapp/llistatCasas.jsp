<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="com.esliceu.bbdd.DAO" %>
<%@ page import="com.esliceu.bbdd.House" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.esliceu.bbdd.HouseDAO" %><%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 27/05/19
  Time: 11:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    DAO<House> dao = null;
    LinkedList<House> casas = null;
%>


<%
    dao = new HouseDAO();
    if (request.getParameter("borrar") != null) {
        dao.delete(dao.findById(Integer.parseInt(request.getParameter("borrar"))));
    }
    casas = dao.findAll();
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
    <input type="text" name="search" id="search" placeholder="Casa aria" value="">
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
                for (House casa : casas) {
                    out.println("<tr class=\"filas\">");
                    out.println("<td>" + casa.getName() + "</td>"); // Col 1
                    out.println("<td><form action=\"modificarCasa.jsp\" method=\"get\" ><button id=\"boton-enviar\" name=\"modificar\" value=\"" + casa.getId() + "\">Modificar</button></form></td>"); // Col2
                    out.println("<td><form action=\"llistatCasas.jsp\" method=\"get\"><button id=\"boton-enviar\" name=\"borrar\" value=\"" + casa.getId() + "\">Eliminar</button></form></td>"); // Col 3
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