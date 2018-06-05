package io.ca.utils;

import java.util.List;
import java.util.stream.Collectors;

import org.modelmapper.ModelMapper;
import org.springframework.stereotype.Component;

@Component
public class Mapper {

	private final ModelMapper mm;

	public Mapper(ModelMapper modelMapper) {
		this.mm = modelMapper;
	}

	public <C, O> C mapper(O o, Class<C> c) {
		return mm.map(o, c);
	}

	public <C, L> List<C> mapper(List<L> ll, Class<C> c) {
		return ll.stream()
				 .map(l -> mapper(l, c))
				 .collect(Collectors.toList());
	}

}
