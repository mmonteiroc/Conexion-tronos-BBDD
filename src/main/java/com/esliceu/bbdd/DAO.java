package com.esliceu.bbdd;

import java.util.LinkedList;
import java.util.List;

/**
 * Creado por: mmonteiro
 * miguelmonteiroclaveri@gmail.com
 * github.com/mmonteiroc
 * Paquete com.esliceu.bbdd
 * Proyecto got
 */
public interface DAO<T extends Entity> {

    LinkedList<T> findAll();

    T findById(Integer id);
    void delete(T entity);
    void update(T entity);
    void create(T entity);

    void establishConnection() throws Exception;


}
