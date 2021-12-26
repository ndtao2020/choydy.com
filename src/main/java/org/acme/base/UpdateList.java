package org.acme.base;

import java.util.List;

public class UpdateList<T> {
    private List<T> inserts;
    private List<T> removes;

    public UpdateList() {
    }

    public UpdateList(List<T> inserts, List<T> removes) {
        this.inserts = inserts;
        this.removes = removes;
    }

    public List<T> getInserts() {
        return inserts;
    }

    public void setInserts(List<T> inserts) {
        this.inserts = inserts;
    }

    public List<T> getRemoves() {
        return removes;
    }

    public void setRemoves(List<T> removes) {
        this.removes = removes;
    }
}
