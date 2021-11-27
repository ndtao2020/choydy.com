package org.acme.base.convert;

import javax.persistence.AttributeConverter;
import javax.persistence.Convert;
import java.util.Arrays;
import java.util.HashSet;
import java.util.Set;

@Convert
public class SetConverter implements AttributeConverter<Set<String>, String> {
    @Override
    public String convertToDatabaseColumn(Set<String> list) {
        if (list == null || list.isEmpty()) return null;
        return String.join(",", list);
    }

    @Override
    public Set<String> convertToEntityAttribute(String dbData) {
        if (dbData == null || dbData.equals("")) return new HashSet<>();
        return new HashSet<>(Arrays.asList(dbData.split(",")));
    }
}
