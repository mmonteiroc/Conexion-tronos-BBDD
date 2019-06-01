package com.esliceu.bbdd;

/**
 * Creado por: mmonteiro
 * miguelmonteiroclaveri@gmail.com
 * github.com/mmonteiroc
 * Paquete com.esliceu.bbdd
 * Proyecto got
 */
public class House extends Entity {

    private Integer id = null;
    private String name = null;


    // Constructor
    public House(String name) {
        this.name = name;
    }

    public House(Integer id, String name) {
        this.id = id;
        this.name = name;
    }


    // Getters
    public Integer getId() {
        return this.id;
    }

    public String getName() {
        return this.name;
    }


}
