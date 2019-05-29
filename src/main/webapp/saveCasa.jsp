<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
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
    Integer casaModificarId = null;
    String nombreCasaNew = null;

    // Atributos para el update
    Connection connection = null;
    Statement statementUpdate = null;
    String queryUpdate = null;


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

        statementUpdate = connection.createStatement();


        casaModificarId = Integer.parseInt(request.getParameter("casaModificar"));
        nombreCasaNew = request.getParameter("newNameHouse");


        queryUpdate = "update house set name=\"" + nombreCasaNew + "\" where id=" + casaModificarId;
        statementUpdate.executeUpdate(queryUpdate);

%>
<html>
<head>
    <title>Titulo</title>
</head>
<body>


<script>
    location.href = "llistatCasas.jsp";
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