/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.promerica.sv.lab.services;

import com.promerica.sv.services.code.ResponseCode;
import java.util.HashMap;
import java.util.Map;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

/**
 *
 * @author easanchez
 */
@Path("/lab-test")
public class ServicesLab {
    
    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public Response listar() {
        HashMap<String, Object> resp = new HashMap(ResponseCode.SUCCESS);
        return Response.ok().entity(resp).build();
    };    
}
