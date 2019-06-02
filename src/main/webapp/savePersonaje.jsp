<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="com.esliceu.bbdd.*" %>
<%@ page import="com.esliceu.bbdd.Character" %>
<%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 28/05/19
  Time: 8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    DAO<Character> dao = new CharacterDAO();
    DAO<House> daoHouse = new HouseDAO();
%>


<%
    Character newpersonaje;
    int personajeModificar = Integer.parseInt(request.getParameter("personajeModificar"));

    if (request.getParameter("casaPersonaje").equals("null")) {
        // Personaje sin casa
        newpersonaje = new Character(personajeModificar, request.getParameter("nombrePersonaje"));
    } else {
        // Personaje con casa
        int casaPersonaje = Integer.parseInt(request.getParameter("casaPersonaje"));
        House house = daoHouse.findById(casaPersonaje);
        newpersonaje = new Character(personajeModificar, request.getParameter("nombrePersonaje"), house);
    }

    dao.update(newpersonaje);

%>
<html>
<head>
    <title>Titulo</title>
</head>
<body>


<script>
    location.href = "llistatPersonajes.jsp";
</script>

</body>
</html>

