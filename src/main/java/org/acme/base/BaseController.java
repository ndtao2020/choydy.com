package org.acme.base;

/**
 * @author Nguyễn Đình Tạo
 */
public class BaseController {
    protected static final String ID = "id";
    protected static final String ID_DESCRIPTION = "Tìm theo id";

    protected static final String SEARCH_PARAM = "search";
    protected static final String SEARCH_DESCRIPTION = "Tìm môt cột của bảng với các điều kiện";

    protected static final String PAGE_PARAM = "p";
    protected static final int PAGE_DEFAULT = 0;
    protected static final String PAGE_DESCRIPTION = "Chọn số trang cho kết quả được gọi (Trang đầu tiên mặc định là 0). Ví Dụ: 0 ";

    protected static final String SIZE_PARAM = "s";
    protected static final int SIZE_DEFAULT = 10;
    protected static final String SIZE_DESCRIPTION = "Chọn số lượng kết quả cho một trang cho kết quả được gọi. Ví Dụ: 10 ";

    protected static final String ORDER_BY_PARAM = "o";
    protected static final String ORDER_BY_DESCRIPTION = "Sắp xếp theo tên một cột ('ASC' là mặc định không cần nhập). Ví Dụ: name desc ";
}
