package kr.co.chunjae.security.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class SecurityConfig {

    private static final String[] AUTHENTICATION_REQUIRED_URIS = {
        "/contents/write/**", "/contents/update/**",
        "/gif/save/**", "/gif/update/**",
        "/packages/loadPackages/**", "/packages/update/**",
        "/video/save/**", "/video/update/**",
        "/template/write/**", "/template/update/**"
    };

    @Bean
    public SecurityFilterChain securityFilterChain(HttpSecurity httpSecurity) throws Exception {
        httpSecurity.formLogin();
        httpSecurity.authorizeRequests().antMatchers(AUTHENTICATION_REQUIRED_URIS).authenticated();
        httpSecurity.authorizeRequests().anyRequest().permitAll();
        httpSecurity.csrf().disable();
        httpSecurity.cors().disable();
        return httpSecurity.build();
    }
}
