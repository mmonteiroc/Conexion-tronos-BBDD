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
    private String sentencia = "select name, id from house";



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
        statement  = connection.createStatement();

        resultado = statement.executeQuery(sentencia);

    } catch (SQLException e) {
        e.printStackTrace();
    }





%>




<html>
<head>
    <title>Form insertar personajes/casas</title>
    <link rel="stylesheet" href="css/general.css">
</head>
<body>

<header>
    <nav>
        <ul>
            <li><a href="formCharacter.jsp">Añadir Characters</a></li>
            <li><a href="llistatPersonajes.jsp">Listado de personajes</a></li>
            <li><a href="llistatCasas.jsp">Listado de Casas</a></li>
        </ul>
    </nav>

</header>


<form action="insertarPersonajes.jsp" method="post" class="insertForm">
    <fieldset>
        <legend>Añadir Caracter</legend>
        <label for="name">Nombre:</label>
        <input type="text" name="name" id="name" placeholder="Tony Stark" required>

        <label for="casa">Casa:</label>
        <select name="casa" id="casa" >
            <option value="null">Sin casa</option>
            <%
                try{
                    while(resultado.next()){
            %>

            <option value="<%=resultado.getInt("id")%>"><%=resultado.getString("name")%></option>

            <%
                    }
                }catch (Exception e){
                    e.printStackTrace();
                }
            %>

        </select>









        <input type="submit" value="Enviar">
    </fieldset>
</form>

<form action="insertarCasa.jsp" method="post" class="insertForm">

    <fieldset>
        <legend>Añadir casa</legend>

        <label for="house-name">Nombre de la casa:</label>
        <input type="text" name="house-name" id="house-name" placeholder="Casa stark" required>


        <input type="submit" value="Añadir casa">
    </fieldset>

</form>

</body>
</html>
