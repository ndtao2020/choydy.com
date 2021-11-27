package org.acme.base.convert;

import javax.persistence.AttributeConverter;
import javax.persistence.Convert;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Convert
public class ListConverter implements AttributeConverter<List<String>, String> {
    @Override
    public String convertToDatabaseColumn(List<String> list) {
        if (list == null || list.isEmpty()) return null;
        return String.join(",", list);
    }

    @Override
    public List<String> convertToEntityAttribute(String dbData) {
        if (dbData == null || dbData.equals("")) return new ArrayList<>();
        return Arrays.asList(dbData.split(","));
    }
}
