package es.pernasferreiro.ml.navrec.es.service;

import es.pernasferreiro.ml.navrec.es.model.Click;
import es.pernasferreiro.ml.navrec.es.repository.ClickRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class ClickServiceImpl implements ClickService {
    @Autowired
    private ClickRepository clickRepository;
/*
    @Autowired
    public void setClickRepository(ClickRepository clickRepository) {
        this.clickRepository = clickRepository;
    }
*/
    public Click save(Click click) {
        return this.clickRepository.save(click);
    }

    public void delete(Click click) {
        this.clickRepository.delete(click);
    }

    public Optional<Click> findOne(String id) {
        return this.clickRepository.findById(id);
    }

    public Iterable<Click> findAll() {
        return this.clickRepository.findAll();
    }

    public Page<Click> findByApplication(String app, PageRequest pageRequest) {
        return this.clickRepository.findByApplication(app, pageRequest);
    }

    public List<Click> findByUser(String user) {
        return this.clickRepository.findByUser(user);
    }

    public List<Click> findByIp(String ip) {
        return this.clickRepository.findByIp(ip);
    }
}
