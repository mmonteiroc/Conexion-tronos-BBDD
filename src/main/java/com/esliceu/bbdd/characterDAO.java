package com.esliceu.bbdd;

import org.apache.commons.dbcp2.BasicDataSource;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.LinkedList;
import java.util.List;

/**
 * Creado por: mmonteiro
 * miguelmonteiroclaveri@gmail.com
 * github.com/mmonteiroc
 * Paquete com.esliceu.bbdd
 * Proyecto got
 */
public class characterDAO implements DAO<Character> {


    Statement statement = null;
    ResultSet resultSet = null;
    Connection connection = null;
    // Pool
    final BasicDataSource pool = new BasicDataSource();
    // BBDD -- Variables
    private final String HOST_BBDD = "jdbc:mysql://localhost:3306";
    private final String NAME_BBDD = "GOT";
    private final String USER_BBDD = "gotAdmin";
    private final String PASSWORD_BBDD = "adminGot";


    @Override
    public List<Character> findAll() {
        LinkedList<Character> returnList = new LinkedList<>();

        try {
            statement = connection.createStatement();
            resultSet = statement.executeQuery("SELECT characters.name as nombre,house.name as casa, characters.id as personajeId FROM characters LEFT JOIN house ON characters.allegianceTo=house.id order by characters.name");

            while (resultSet.next()) {
                returnList.addLast(new Character(resultSet.getInt("personajeID"), resultSet.getString("nombre"), new House()));
            }


        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Aqui tendremos que cerrar la conexion
            try {

                if (resultSet != null) resultSet.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }


        return returnList;
    }

    @Override
    public void delete(Character entity) {

    }

    @Override
    public void update(Character entity) {

    }

    @Override
    public void create(Character entity) {

    }


    private void establishConnection() {
        try {
            Class.forName("com.mysql.jdbc.Driver").newInstance();


        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

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


    }


}
