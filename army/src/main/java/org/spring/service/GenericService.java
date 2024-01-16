package org.spring.service;

import java.util.List;

public interface GenericService<VO, K> {
	public VO update(VO vo);
	public List<VO> listAll();
	public VO insert(VO vo);
	public int delete(K k);
	public VO find(K k);
}
