package info.ejava.examples.secureping.rs;

import javax.annotation.security.PermitAll;
import javax.ejb.EJB;
import javax.ejb.EJBAccessException;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.Response.ResponseBuilder;
import javax.ws.rs.core.SecurityContext;
import javax.ws.rs.core.UriInfo;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import info.ejava.examples.secureping.dto.PingResult;
import info.ejava.examples.secureping.ejb.SecurePing;
import info.ejava.examples.secureping.ejb.SecurePingLocal;

@Path("ping")
@PermitAll
public class SecurePingResource {
    @SuppressWarnings("unused")
    private static final Logger logger = LoggerFactory.getLogger(SecurePingResource.class);
    
    //@EJB(lookup="ejb:securePingEAR/securePingEJB/SecurePingEJB!info.ejava.examples.secureping.ejb.SecurePingRemote")
    @EJB(beanName="SecurePingEJB", beanInterface=SecurePingLocal.class)
    private SecurePing secureService;
    
    @Context
    private SecurityContext ctx;
    @Context
    private UriInfo uriInfo;
    
    @Path("whoAmI")
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public Response whoAmiI() {
        ResponseBuilder rb = null;
        try {
            if (secureService!=null) {
                rb = Response.ok(secureService.whoAmI());
            } else {
                rb = Response.serverError().entity("no ejb injected!!!"); 
            }
        } catch (Exception ex) {
            rb=makeExceptionResponse(ex);
        }
        
        return rb.build();
    }
    
    @Path("roles/{role}")
    @GET
    @Produces(MediaType.TEXT_PLAIN)
    public Response isCallerInRole(@PathParam("role") String role) {
        ResponseBuilder rb = null;
        try {
            if (secureService!=null) {
                rb = Response.ok(secureService.isCallerInRole(role));
            } else {
                rb = Response.serverError().entity("no ejb injected!!!"); 
            }
        } catch (Exception ex) {
            rb=makeExceptionResponse(ex);
        }
        
        return rb.build();        
    }
    
    @Path("admin")
    //@RolesAllowed("admin")
    public Pinger admin() {
        return new Pinger();
    }

    @Path("user")
    //@RolesAllowed("user")
    public Pinger user() {
        return new Pinger();
    }

    @Path("")
    public Pinger anonymous() {
        return new Pinger();
    }
    
    public class Pinger {
        @Path("pingAdmin")
        @GET
        @Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
        public Response pingAdmin() {
            ResponseBuilder rb = null;
            try {
                PingResult result = makeResourcePayload(secureService!=null ?
                        secureService.pingAdmin() : "no ejb injected!!!");
                rb = secureService!=null ? 
                        Response.ok(result) :
                        Response.serverError().entity(result);
            } catch (EJBAccessException ex) {
                PingResult entity = makeResourcePayload(ex.toString());
                rb = Response.serverError().entity(entity);                
            } catch (Exception ex) {
                rb=makeExceptionResponse(ex);
            }
            
            return rb.build();
        }

        @Path("pingUser")
        @GET
        @Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
        public Response pingUser() {
            ResponseBuilder rb = null;
            try {
                PingResult result = makeResourcePayload(secureService!=null ?
                        secureService.pingUser() : "no ejb injected!!!");
                rb = secureService!=null ? 
                        Response.ok(result) :
                        Response.serverError().entity(result);
            } catch (EJBAccessException ex) {
                PingResult entity = makeResourcePayload(ex.toString());
                rb = Response.serverError()
                             .entity(entity);                
            } catch (Exception ex) {
                rb=makeExceptionResponse(ex);
            }
            
            return rb.build();
        }

        @Path("pingAll")
        @GET
        @Produces({MediaType.APPLICATION_JSON, MediaType.APPLICATION_XML})
        public Response pingAll() {
            ResponseBuilder rb = null;
            try {
                PingResult result = makeResourcePayload(secureService!=null ?
                        secureService.pingAll() : "no ejb injected!!!");
                rb = secureService!=null ? 
                        Response.ok(result) :
                        Response.serverError().entity(result);
            } catch (Exception ex) {
                rb=makeExceptionResponse(ex);
            }
            
            return rb.build();
        }
    }
    
    private ResponseBuilder makeExceptionResponse(Exception ex) {
        return Response.serverError()
                .entity(String.format("unexpected error calling secureService: %s",  ex.toString()));
    }
    
    private PingResult makeResourcePayload(String ejbResponse) {
        String context = uriInfo.getAbsolutePath().toString();
        String userName = ctx.getUserPrincipal()==null ? null : ctx.getUserPrincipal().getName();
        boolean isAdmin = ctx.isUserInRole("admin");
        boolean isUser = ctx.isUserInRole("user");
        
        PingResult result = new PingResult(context, userName, isAdmin, isUser);
        result.setServiceResult(ejbResponse);
        return result;
    }

}
