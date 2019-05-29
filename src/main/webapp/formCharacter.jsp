<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %><%--
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
    private final String HOST_BBDD = "jdbc:mysql://localhost:3306";
    private final String NAME_BBDD = "GOT";
    private final String USER_BBDD = "gotAdmin";
    private final String PASSWORD_BBDD = "adminGot";
    // Pool
    final BasicDataSource pool = new BasicDataSource();



%>

<%
    try {
        Class.forName("com.mysql.jdbc.Driver").newInstance();

        // Conexion
        pool.setDefaultCatalog(NAME_BBDD);
        pool.setUsername(USER_BBDD);
        pool.setPassword(PASSWORD_BBDD);
        pool.setUrl(HOST_BBDD);

        // Parametros
        pool.setMaxIdle(10);
        pool.setMinIdle(1);
        pool.setMaxTotal(5);
        pool.setValidationQuery("select 1");
        pool.setValidationQueryTimeout(1);
        pool.setDefaultQueryTimeout(15);
        pool.setMaxWaitMillis(2000);


    } catch (Exception e) {
        e.printStackTrace();
    }

    try {

        connection = pool.getConnection();

        // Sacamos las casas para el combo box
        statement  = connection.createStatement();
        sentencia = "select name, id from house order by name";
        resultado = statement.executeQuery(sentencia);


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
            <li><a href="formCharacter.jsp">Añadir Characters/Casas</a></li>
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
                        out.println("<option value=\"" + resultado.getInt("id") + "\">" + resultado.getString("name") + "</option>");
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