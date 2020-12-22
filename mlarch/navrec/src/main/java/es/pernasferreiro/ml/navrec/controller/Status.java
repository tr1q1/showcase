package es.pernasferreiro.ml.navrec.controller;

import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/api/v1")
public class Status {
    @RequestMapping(value = "/status", method = RequestMethod.GET)
    public List<String> getStatus() {
        List<String> resultados = new ArrayList<>(0);
        resultados.add("It's alive!!!");

        return resultados;
    }
}