package org.acme.base;

import lombok.Data;

import java.util.List;

@Data
public class QueryPage {
    private List<?> l;
    private Object t;

    public QueryPage(List<?> list, Object total) {
        this.l = list;
        this.t = total;
    }
}
