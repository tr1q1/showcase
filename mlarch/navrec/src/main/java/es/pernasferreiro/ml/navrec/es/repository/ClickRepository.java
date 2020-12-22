package es.pernasferreiro.ml.navrec.es.repository;

import es.pernasferreiro.ml.navrec.es.model.Click;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.elasticsearch.repository.ElasticsearchRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ClickRepository extends ElasticsearchRepository<Click, String> {
    Page<Click> findByApplication(String app, Pageable pageable);

    List<Click> findByUser(String user);

    List<Click> findByIp(String ip);
}
