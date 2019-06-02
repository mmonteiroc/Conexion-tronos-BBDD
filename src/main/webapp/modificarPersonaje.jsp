<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="com.esliceu.bbdd.DAO" %>
<%@ page import="com.esliceu.bbdd.HouseDAO" %>
<%@ page import="com.esliceu.bbdd.House" %>
<%@ page import="java.util.LinkedList" %>
<%@ page import="com.esliceu.bbdd.CharacterDAO" %>
<%@ page import="com.esliceu.bbdd.Character" %><%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 27/05/19
  Time: 23:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!

    DAO<House> dao = new HouseDAO();
    DAO<Character> daoCaracter = new CharacterDAO();
    Character personajeAModificar = null;

    Integer idPersonaje = null;
    LinkedList<House> totalCasas = null;
%>

<%
    totalCasas = dao.findAll();
    // Personaje a modificar
    idPersonaje = Integer.parseInt(request.getParameter("modificar"));
    personajeAModificar = daoCaracter.findById(idPersonaje);
%>


<html>
<head>
    <title>Modificar <%=personajeAModificar.getName()%>
    </title>
</head>
<body>


<form action="savePersonaje.jsp" method="post">

    <label for="nombrePersonaje">Nombre de tu personaje</label>
    <input type="text" name="nombrePersonaje" id="nombrePersonaje" value="<%=personajeAModificar.getName()%>">


    <label for="casaPersonaje">Casa lealtad</label>
    <select name="casaPersonaje" id="casaPersonaje">
        <option value="null">Sin casa</option>


        <%
            for (House casa : totalCasas) {
                out.println("<option value=\"" + casa.getId() + "\">");
                out.println(casa.getName());
                out.println("</option>");
            }
        %>

    </select>


    <button name="personajeModificar" value="<%=idPersonaje%>">Guardar datos</button>

</form>


</body>
</html>


