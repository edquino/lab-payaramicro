/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.promerica.sv.services.code;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author easanchez
 */
public class ResponseCode implements Serializable{

    public static final Map<String, Object> SUCCESS = new HashMap<String, Object>() {
        {
            put("pCodRespuesta", "000000");
            put("pMensajeTecnico", "Transaccion exitosa");
            put("pMensajeUsuario", "Transaccion exitosa");
        }
    };
}
