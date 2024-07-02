package br.com.ufrn.levaeu.service;

import br.com.ufrn.levaeu.model.Token;
import br.com.ufrn.levaeu.model.User;
import br.com.ufrn.levaeu.repository.TokenRepository;
import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTCreationException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneOffset;
import java.util.List;


@Service
public class TokenService {

    private final TokenRepository tokenRepository;

    @Value("${api.security.token.secret}")
    private String secret;

    public TokenService(TokenRepository tokenRepository) {
        this.tokenRepository = tokenRepository;
    }


    public String generateToken(User user) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(secret);
            String token = JWT.create()
                    .withIssuer("auth-user")
                    .withSubject(user.getEmail())
                    .withExpiresAt(generateExpirationDate())
                    .sign(algorithm);

            return token;
        } catch (JWTCreationException ex) {
            throw new RuntimeException("Erro enquanto tentava gerar token");
        }
    }

    public String validateToken(String token) {
        try {
            Algorithm algorithm = Algorithm.HMAC256(secret);
            token = token.trim();
            return JWT.require(algorithm)
                    .withIssuer("auth-user")
                    .build()
                    .verify(token)
                    .getSubject();
        } catch (JWTVerificationException ex) {
            return "";
        }
    }

    public String resolveToken(HttpServletRequest req) {
        String authHeader = req.getHeader("Authorization");
        if (authHeader == null) {
            return null;
        }

        return authHeader.replace("Bearer", "").trim();
    }

    private Instant generateExpirationDate(){
        return LocalDateTime.now().plusHours(24).toInstant(ZoneOffset.of("-03:00"));
    }

    public void saveToken(String jwtToken, User user) {
        Token token = new Token();
        token.setToken(jwtToken);
        token.setUser(user);
        token.setExpired(false);
        token.setRevoked(false);
        tokenRepository.save(token);
    }

    public void revokeAllUserTokens(User user) {
        List<Token> validUsertokens = tokenRepository.findAllValidTokensByUser(user.getId());
        if(validUsertokens.isEmpty()){
            return;
        }

        for(Token token : validUsertokens){
            token.setRevoked(true);
            token.setExpired(true);
        }
        tokenRepository.saveAll(validUsertokens);
    }
}
