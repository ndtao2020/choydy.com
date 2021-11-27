package org.acme.base;

import lombok.Data;

import java.util.List;

@Data
public class QueryPage {
    private List<?> list;
    private Object total;

    public QueryPage(List<?> list, Object total) {
        this.total = total;
        this.list = list;
    }
}
