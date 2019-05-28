<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 27/05/19
  Time: 23:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!

    Integer idPersonaje = null;
    String nombrePersonaje = null;
    Connection connection = null;
    Statement statement = null;
    ResultSet resultSet = null;
    String sentencia = "";

    // Para sacar casas
    Statement statementCasas = null;
    ResultSet resultadoCasas = null;
    String queryCasas = null;


    // BBDD -- Variables
    private final String HOST_BBDD = "localhost";
    private final Integer PORT_BBDD = 3306;
    private final String NAME_BBDD = "GOT";
    private final String USER_BBDD = "miguel";
    private final String PASSWORD_BBDD = "monteiro";
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
        statement = connection.createStatement();

        idPersonaje = Integer.parseInt(request.getParameter("modificar"));

        // Sacamos informacion del personaje a modificar
        sentencia = "select name from characters where characters.id=" + idPersonaje;
        resultSet = statement.executeQuery(sentencia);


        try {
            resultSet.next();
            nombrePersonaje = resultSet.getString("name");
        } catch (SQLException e) {
            e.printStackTrace();
        }


        // Sacamos casas
        statementCasas = connection.createStatement();
        queryCasas = "select * from house order by name";
        resultadoCasas = statementCasas.executeQuery(queryCasas);


%>


<html>
<head>
    <title>Modificar <%=nombrePersonaje%>
    </title>
</head>
<body>


<form action="savePersonaje.jsp" method="post">

    <label for="nombrePersonaje">Nombre de tu personaje</label>
    <input type="text" name="nombrePersonaje" id="nombrePersonaje" value="<%=nombrePersonaje%>">


    <label for="casaPersonaje">Casa lealtad</label>
    <select name="casaPersonaje" id="casaPersonaje">
        <option value="null">Sin casa</option>


        <%

            try {
                while (resultadoCasas.next()) {
                    out.println("<option value=\"" + resultadoCasas.getInt("id") + "\">");
                    out.println(resultadoCasas.getString("name"));
                    out.println("</option>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

        %>

    </select>


    <button name="personajeModificar" value="<%=idPersonaje%>">Guardar datos</button>

</form>


</body>
</html>


<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (resultadoCasas != null) resultadoCasas.close();
            if (statementCasas != null) statementCasas.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
