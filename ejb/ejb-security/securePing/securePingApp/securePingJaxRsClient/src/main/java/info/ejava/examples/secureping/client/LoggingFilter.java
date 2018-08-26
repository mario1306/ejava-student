package info.ejava.examples.secureping.client;

import java.io.IOException;

import javax.ws.rs.client.ClientRequestContext;
import javax.ws.rs.client.ClientResponseContext;
import javax.ws.rs.client.ClientResponseFilter;
import javax.ws.rs.core.Response.StatusType;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LoggingFilter implements ClientResponseFilter {
    private final Logger logger;
    
    public LoggingFilter(Logger logger) {
        this.logger = logger;
    }
    public LoggingFilter() {
        this(LoggerFactory.getLogger(LoggingFilter.class));
    }
    
    @Override
    public void filter(ClientRequestContext requestContext, ClientResponseContext responseContext) throws IOException {
        String method = requestContext.getMethod();
        String uri = requestContext.getUri().toString();
        StatusType status = responseContext.getStatusInfo();
        logger.debug("{} {}, returned {}", method, uri, status);
    }
}
