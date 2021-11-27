package org.acme.base.func;

@FunctionalInterface
public interface FuncInitObject<T, K> {
    T setData(K init);
}
