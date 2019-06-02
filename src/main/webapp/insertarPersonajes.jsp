<%@ page import="jdk.nashorn.internal.runtime.ECMAException" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%@ page import="com.esliceu.bbdd.*" %>
<%@ page import="com.esliceu.bbdd.Character" %><%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 24/05/19
  Time: 18:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    String name = "";
    Integer idCasa = null;
    DAO<House> daoCasa = new HouseDAO();
    DAO<Character> daoCharacter = new CharacterDAO();
    Character personaje = null;
    House casa = null;
%>

<%


    name = request.getParameter("name");

    if (request.getParameter("casa").equals("null")) {
        // Sin casa
        personaje = new Character(name);
    } else {
        // con casa
        idCasa = Integer.parseInt(request.getParameter("casa"));
        casa = daoCasa.findById(idCasa);
        personaje = new Character(name, casa);
    }
    daoCharacter.create(personaje);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>insertar</title>
</head>
<body>



<script>
    location.href = "llistatPersonajes.jsp";
</script>

</body>
</html>

