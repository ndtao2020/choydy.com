package org.acme.base;

import lombok.Data;

import java.util.List;

@Data
public class UpdateList<T> {
    private List<T> inserts;
    private List<T> removes;

    public UpdateList(List<T> inserts, List<T> removes) {
        this.inserts = inserts;
        this.removes = removes;
    }
}
