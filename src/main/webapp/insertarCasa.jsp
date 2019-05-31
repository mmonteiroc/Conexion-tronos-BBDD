<%@ page import="java.sql.*" %>
<%@ page import="org.apache.commons.dbcp2.BasicDataSource" %>
<%--
  Created by IntelliJ IDEA.
  User: mmonteiro
  Date: 25/05/19
  Time: 21:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>

<%!
    String nameCasa = "";
    Connection connection = null;
    Statement statement = null;
    String sentencia = "";



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


        statement  = connection.createStatement();


        nameCasa = request.getParameter("house-name");

        sentencia="insert into house (name) values (\""+nameCasa+"\")";
        statement.execute(sentencia);

%>


<html>
<head>
    <title>Title</title>
</head>
<body>
<%=sentencia%>


<script>

    //    setTimeout(function () {
    location.href = "llistatCasas.jsp";
    //    },10000)

</script>


</body>
</html>


<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        try {
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>