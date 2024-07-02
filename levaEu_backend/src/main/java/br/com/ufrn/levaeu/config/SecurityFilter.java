package br.com.ufrn.levaeu.config;

import br.com.ufrn.levaeu.model.User;
import br.com.ufrn.levaeu.repository.TokenRepository;
import br.com.ufrn.levaeu.repository.UserRepository;
import br.com.ufrn.levaeu.service.AuthService;
import br.com.ufrn.levaeu.service.TokenService;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Component
public class SecurityFilter extends OncePerRequestFilter {

    private final TokenService tokenService;
    private final UserRepository userRepository;
    private final AuthService authService;
    private final TokenRepository tokenRepository;

    public SecurityFilter(TokenService tokenService, UserRepository userRepository, AuthService authService, TokenRepository tokenRepository) {
        this.tokenService = tokenService;
        this.userRepository = userRepository;
        this.authService = authService;
        this.tokenRepository = tokenRepository;
    }

    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        String token = this.recoverToken(request);
        if (token != null) {
            String login = tokenService.validateToken(token);

            UserDetails user = authService.loadUserByUsername(login);

            boolean isTokenValid = tokenRepository.findByToken(token)
                .map(t -> !t.isExpired() && !t.isRevoked())
                .orElse(false);

            if(isTokenValid){
                UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(user, null, user.getAuthorities());
                SecurityContextHolder.getContext().setAuthentication(authentication);
            } else {
                throw new ServletException("O token inserido não é mais válido, por favor faça login novamente");
            }
        }

        filterChain.doFilter(request, response);
    }

    private String recoverToken(HttpServletRequest request) {
        String authHeader = request.getHeader("Authorization");
        if (authHeader == null) {
            return null;
        }

        return authHeader.replace("Bearer", "").trim();
    }
}
