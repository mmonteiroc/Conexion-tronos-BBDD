<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 28/05/19
  Time: 8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%!
    // Atributos que recibiremos por post
    Integer personajeModificarID = null;
    String nombrePersonaje = null;
    Integer casaPersonaje = null;

    // Atributos para el update
    Connection connection = null;
    Statement statementUpdate = null;
    String queryUpdate = null;


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

        // establecemos conexion
        connection = DriverManager.getConnection("jdbc:mysql://"
                + HOST_BBDD + ":"
                + PORT_BBDD.toString() + "/"
                + NAME_BBDD + "?user="
                + USER_BBDD + "&password="
                + PASSWORD_BBDD);

        statementUpdate = connection.createStatement();


        personajeModificarID = Integer.parseInt(request.getParameter("personajeModificar"));
        nombrePersonaje = request.getParameter("nombrePersonaje");

        if (request.getParameter("casaPersonaje").equals("null")) {
            // Personaje sin casa
            queryUpdate = "update characters set name=\"" + nombrePersonaje + "\",allegianceTo=" + null + " where id=" + personajeModificarID;

        } else {
            // Personaje con casa
            casaPersonaje = Integer.parseInt(request.getParameter("casaPersonaje"));
            queryUpdate = "update characters set name=\"" + nombrePersonaje + "\",allegianceTo=" + casaPersonaje + " where id=" + personajeModificarID;
        }

        statementUpdate.executeUpdate(queryUpdate);

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

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (statementUpdate != null) statementUpdate.close();
            if (connection != null) connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>