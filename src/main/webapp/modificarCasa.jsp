<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 29/05/19
  Time: 9:32
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%!

    Integer idCasa = null;
    String nombreCasa = null;
    String sentencia = null;

    ResultSet resultSet = null;
    Statement statement = null;
    Connection connection = null;


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
        statement = connection.createStatement();

        idCasa = Integer.parseInt(request.getParameter("modificar"));

        // Sacamos informacion del personaje a modificar
        sentencia = "select name from house where id=" + idCasa;
        resultSet = statement.executeQuery(sentencia);


        try {
            resultSet.next();
            nombreCasa = resultSet.getString("name");
        } catch (SQLException e) {
            e.printStackTrace();
        }


%>


<html>
<head>
    <title>Modificar <%=nombreCasa%>
    </title>
</head>
<body>

<form action="saveCasa.jsp">
    <input type="text" name="newNameHouse" value="<%=nombreCasa%>">
    <button name="casaModificar" value="<%=idCasa%>">Guardar datos</button>
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
            if (connection != null) connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>