<%@ page import="com.esliceu.bbdd.DAO" %>
<%@ page import="com.esliceu.bbdd.House" %>
<%@ page import="com.esliceu.bbdd.HouseDAO" %>
<%@ page import="java.util.LinkedList" %><%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 24/05/19
  Time: 18:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    DAO<House> dao = new HouseDAO();
    LinkedList<House> listaCasasTotal = null;
%>

<%
    listaCasasTotal = dao.findAll();
%>


<html>
<head>
    <title>Form insertar personajes/casas</title>
    <link rel="stylesheet" href="css/formAdd.css">
</head>
<body class="personajes">

<header>
    <nav>
        <ul>
            <li><a href="formCharacter.jsp">ADD Characters and Houses</a></li>
            <li><a href="llistatPersonajes.jsp">Listado de personajes</a></li>
            <li><a href="llistatCasas.jsp">Listado de Casas</a></li>
        </ul>
    </nav>

</header>

<div class="caja-form">


    <form action="insertarPersonajes.jsp" method="post" class="insertFormCharacter">
        <span>Add character</span>
        <label for="name">Nombre:</label>
        <input type="text" name="name" id="name" placeholder="Jonh Snow" required>

        <label for="casa">Casa:</label>
        <select name="casa" class="select-selected" id="casa">
            <option value="null">Sin casa</option>
            <%
                for (House casa : listaCasasTotal) {
                    out.println("<option value=\"" + casa.getId() + "\">" + casa.getName() + "</option>");
                }
            %>

        </select>

        <input type="submit" class="boton-enviar" value="Enviar">
    </form>

    <form action="insertarCasa.jsp" method="get" class="insertFormHouse">

        <span>Add house</span>

        <label for="house-name">Nombre de la casa:</label>
        <input type="text" name="house-name" id="house-name" placeholder="Casa stark" required>


        <input type="submit" class="boton-enviar" value="Enviar">

    </form>

</div>


</body>
</html>

