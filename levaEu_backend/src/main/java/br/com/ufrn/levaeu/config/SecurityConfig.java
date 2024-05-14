package br.com.ufrn.levaeu.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable()) // Desabilita CSRF
                .authorizeHttpRequests(authz -> authz
                        .requestMatchers("/**").permitAll() // Permite todas as requisições para todos os caminhos
                        .anyRequest().authenticated() // Assegura que todas as outras requisições sejam autenticadas
                )
                .httpBasic(withDefaults()); // Habilita autenticação básica

        return http.build();
    }
}

