<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 24/05/19
  Time: 18:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!
    private Connection connection = null;
    private Statement statement = null;
    private ResultSet resultado = null;
    private String sentencia = null;


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


        // Definimos conexion
        try {
            connection = DriverManager.getConnection("jdbc:mysql://"
                    + HOST_BBDD + ":"
                    + PORT_BBDD.toString() + "/"
                    + NAME_BBDD + "?user="
                    + USER_BBDD + "&password="
                    + PASSWORD_BBDD);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Sacamos las casas para el combo box
        statement = connection.createStatement();
        sentencia = "select name, id from house order by name";
        resultado = statement.executeQuery(sentencia);


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
            <li><a href="formCharacter.jsp">Añadir Characters / Casas</a></li>
            <li><a href="llistatPersonajes.jsp">Listado de personajes</a></li>
            <li><a href="llistatCasas.jsp">Listado de Casas</a></li>
        </ul>
    </nav>

</header>

<div class="caja-form">


    <form action="insertarPersonajes.jsp" method="post" class="insertFormCharacter">
        <p>Personaje</p>
        <label for="name">Nombre:</label>
        <input type="text" name="name" id="name" placeholder="Jonh Snow" required>

        <label for="casa">Casa:</label>
        <select name="casa" class="select-selected" id="casa">
            <option value="null">Sin casa</option>
            <%
                try {
                    while (resultado.next()) {
                        out.println("<option value=\"" + resultado.getInt("id") + "\">" + resultado.getString("name") + "</option>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            %>

        </select>


        <input type="submit" class="boton-enviar" value="Enviar">
    </form>

    <form action="insertarCasa.jsp" method="post" class="insertFormHouse">

        <p>Casa</p>

        <label for="house-name">Nombre de la casa:</label>
        <input type="text" name="house-name" id="house-name" placeholder="Casa stark" required>


        <input type="submit" class="boton-enviar" value="Enviar">

    </form>

</div>


</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (resultado != null) resultado.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>