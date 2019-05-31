package com.esliceu.bbdd;

import java.util.List;

/**
 * Creado por: mmonteiro
 * miguelmonteiroclaveri@gmail.com
 * github.com/mmonteiroc
 * Paquete com.esliceu.bbdd
 * Proyecto got
 */
public interface DAO<T extends Entity> {

    List<T> findAll();

    void delete(Integer id);


}
