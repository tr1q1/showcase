package es.pernasferreiro.ml.navrec.es.service;

import es.pernasferreiro.ml.navrec.es.model.Click;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;

import java.util.List;
import java.util.Optional;

public interface ClickService {
    Click save(Click click);

    void delete(Click click);

    Optional<Click> findOne(String id);

    Iterable<Click> findAll();

    Page<Click> findByApplication(String app, PageRequest pageable);

    List<Click> findByUser(String user);

    List<Click> findByIp(String ip);
}
