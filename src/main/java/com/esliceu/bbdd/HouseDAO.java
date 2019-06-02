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
public class HouseDAO implements DAO<House> {
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


    public HouseDAO() {
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


    @Override
    public LinkedList<House> findAll() {
        LinkedList<House> casas = new LinkedList<>();
        try {
            establishConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select id,name from house order by name");
            while (resultSet.next()) {
                casas.addLast(new House(resultSet.getInt("id"), resultSet.getString("name")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) connection.close();
                if (statement != null) statement.close();
                if (resultSet != null) resultSet.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }


        return casas;
    }

    @Override
    public House findById(Integer id) {
        House devolver = null;
        try {
            establishConnection();
            statement = connection.createStatement();
            resultSet = statement.executeQuery("select name,id from house where id=" + id);
            resultSet.next();
            devolver = new House(resultSet.getInt("id"), resultSet.getString("name"));

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) connection.close();
                if (statement != null) statement.close();
                if (resultSet != null) resultSet.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return devolver;
    }

    @Override
    public void delete(House entity) {
        try {
            establishConnection();
            statement = connection.createStatement();
            Statement safeUpdates0 = connection.createStatement();
            safeUpdates0.execute("SET SQL_SAFE_UPDATES = 0");
            statement.executeUpdate("update characters set allegianceTo = null where allegianceTo=" + entity.getId());
            safeUpdates0.execute("SET SQL_SAFE_UPDATES = 1");

            statement = connection.createStatement();
            statement.executeUpdate("delete from house where id=" + entity.getId());
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) connection.close();
                if (statement != null) statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void update(House entity) {
        try {
            establishConnection();
            statement = connection.createStatement();
            statement.executeUpdate("update house set name=\"" + entity.getName() + "\" where id=" + entity.getId());
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) connection.close();
                if (statement != null) statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void create(House entity) {
        try {
            establishConnection();
            statement = connection.createStatement();
            statement.executeUpdate("insert into house(name) values ('" + entity.getName() + "')");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (connection != null) connection.close();
                if (statement != null) statement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    @Override
    public void establishConnection() throws ClassNotFoundException, IllegalAccessException, InstantiationException, SQLException {
        connection = pool.getConnection();
    }
}
