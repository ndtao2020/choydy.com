package org.acme.base;

import java.util.List;

public class QueryPage {
    private List<?> l;
    private Object t;

    public QueryPage() {
    }

    public QueryPage(List<?> list, Object total) {
        this.l = list;
        this.t = total;
    }

    public List<?> getL() {
        return l;
    }

    public void setL(List<?> l) {
        this.l = l;
    }

    public Object getT() {
        return t;
    }

    public void setT(Object t) {
        this.t = t;
    }
}
