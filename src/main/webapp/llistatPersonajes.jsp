<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.esliceu.bbdd.CharacterDAO" %>
<%@ page import="com.esliceu.bbdd.DAO" %>
<%@ page import="com.esliceu.bbdd.Character" %>
<%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 24/05/19
  Time: 17:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!

    DAO<Character> dao = null;
    LinkedList<Character> caracteres = null;
%>
<%

    try {

        dao = new CharacterDAO();
        if (request.getParameter("borrar") != null) {
            dao.delete(dao.findById(Integer.parseInt(request.getParameter("borrar"))));
        }

        caracteres = dao.findAll();

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
    <input type="text" name="search" id="search" placeholder="Capitan" value="">
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
                for (Character carracter : caracteres) {
                    out.println("<tr class=\"filas\">");
                    out.println("<td>" + carracter.getName() + "</td>"); // Col 1
                    if (carracter.getAllegianceTo().getName() == null) {
                        out.println("<td></td>");
                    } else {
                        out.println("<td>" + carracter.getAllegianceTo().getName() + "</td>");
                    }
                    out.println("<td><form action=\"modificarPersonaje.jsp\" method=\"get\" ><button id= \"boton-enviar\" name=\"modificar\" value=\"" + carracter.getId() + "\">Modificar</button></form></td>");
                    out.println("<td><form action=\"llistatPersonajes.jsp\" method=\"get\"><button id= \"boton-enviar\" name=\"borrar\" value=\"" + carracter.getId() + "\">Eliminar</button></form></td>"); // Col 3
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
        if (dao != null) dao = null;
        if (caracteres != null) caracteres = null;
    }
%>