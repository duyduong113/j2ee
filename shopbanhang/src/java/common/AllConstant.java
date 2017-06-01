/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package common;

/**
 *
 * @author DUONG
 */
public class AllConstant {

    //Group User
    public static String Group_ADMIN = "ADMIN";
    public static String Group_MEMBER = "MEMBER";
    public static String Group_MOD = "MOD";
    //Trạng thái đơn hàng
    public static int Order_NEW = 1;
    public static int Order_APPROVE = 2;
    public static int Order_CANCEL = 3;
    //Hệ thống  
    public static String System = "System";
    //Parameter Product
    public static String Product_LATEST = "LATEST";
    public static String Product_FEATURED = "FEATURED";
    public static String Product_RELATED = "RELATED";
    public static String Product_ALL = "ALL";
    public static String Product_BYCATEGORY = "BYCATEGORY";
    public static String Product_PROMOTION = "PROMOTION";
    public static String Product_SEARCH = "SEARCH";
    //Phân trang
    public static int Paging_record = 8;
    public static int Paging_record_Admin = 4;
    public static int Paging_FetchNext = 1000;
    public static int Paging_Offset = 0;
    //Trạng thái sử dụng
    public static String Status_True = "Đang sử dụng";
    public static String Status_False = "Không sử dụng";

    //Type ACTION
    public static String Action_INSERT = "INSERT";
    public static String Action_UPDATE = "UPDATE";

    //Setting Upload 
    // location to store file uploaded
    public static final String UPLOAD_DIRECTORY_PRODUCTS = "upload/products";
    public static final String UPLOAD_DIRECTORY_CATEGORYS = "upload/categorys";
    public static final String UPLOAD_DIRECTORY_USERS = "upload/users";
    public static final String UPLOAD_DIRECTORY = "upload";
    // upload settings
    public static final int MEMORY_THRESHOLD = 1024 * 1024 * 3;  // 3MB
    public static final int MAX_FILE_SIZE = 1024 * 1024 * 40; // 40MB
    public static final int MAX_REQUEST_SIZE = 1024 * 1024 * 50; // 50MB

    //prefix
    public static final String Prefix_Product = "SP";
    public static final String Prefix_StockIn = "PN";
    public static final String Prefix_CheckInventory = "PK";

    //trạng thai đơn hàng
    public static final String Order_Status_New = "Chờ duyệt";
    public static final String Order_Status_Approved = "Đã duyệt";
    public static final String Order_Status_Canceled = "Đã hủy";

    //trang thái feedback
    public static final String Feedback_Status_New = "Chưa đọc";
    public static final String Feedback_Status_Approved = "Đã đọc";

    //password dèfault
    public static final String Password_Default = "12345";

    //Error validate
    public static final String Error_Email_Exist = "Địa chỉ Email này đã tồn tại!";
    public static final String Error_Email_Not_Correct = "Địa chỉ Email không hợp lệ!";
    public static final String Error_UserName_Exist = "Tên đăng nhập đã tồn tại!";
    public static final String Error_Phone_Exist = "Số điện thoại này đã tồn tại!";

    //error
    public static final String Error_Exist = "Exist";
    public static final String Error_Not_Correct = "Not_Correct";

    //Mail server
    public static final String Mail_Address = "duyduonglongbinh001@gmail.com";
    public static final String Mail_Password = "ÓỌÕỘÓỘPÕ";
    public static final String Mail_Key = "12520091";

    //Số lượng sản phẩm lấy ra
    public static int Product_LATEST_Quantity = 4;
    public static int Product_FEATURED_Quantity = 4;
    public static int Product_RELATED_Quantity = 4;
    //Link ảnh no-image
    public static String url_no_image = "images/products/no-image-product.png";
    public static String url_no_image_general = "images/generals/no-image.png";
    //Vị trí GG MAP
    public static String Localtion = "https://www.google.com/maps/dir//''/@10.8702038,106.7336958,12z/data=!3m1!4b1!4m8!4m7!1m0!1m5!1m1!1s0x317527587ba04377:0x4ea5c6ca79f1ff59!2m2!1d106.8037364!2d10.8702117";

    
    
    //Mail order NEW
    public String MailNewOrder(String Name, String username, String fullname, String phone, String email, String total, String content) {
        String MailContent = "<!DOCTYPE html>\n"
                + "<head>\n"
                + "     <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n"
                + "	<title>kingphone</title>\n"
                + "</head>\n"
                + "<body class=\"article\">\n"
                + "	<div class=\"content\">\n"
                + "		<div id=\":1lv\" class=\"a3s aXjCH m15a6199373fd7f0b\">\n"
                + "			<div dir=\"ltr\">\n"
                + "				<p class=\"MsoNormal\" style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<em>\n"
                + "							<span style=\"font-family:arial,sans-serif\">Xin chào&nbsp;\n"
                + "								<b>" + Name + ",&nbsp;</b>\n"
                + "							</span>\n"
                + "						</em>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\">\n"
                + "							<span></span>\n"
                + "					</span>\n"
                + "				</p>\n"
                + "				<p class=\"MsoNormal\" style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<i>\n"
                + "							<span style=\"font-family:arial,sans-serif\">\n"
                + "								<br>\n"
                + "									<em>\n"
                + "										<span style=\"font-family:arial,sans-serif\">Cảm ơn bạn đã đặt hàng tại trang web</span>\n"
                + "									</em>\n"
                + "									<em>\n"
                + "										<b>\n"
                + "											<span style=\"font-family:arial,sans-serif\">\n"
                + "												<a href=\"http://localhost:8080/shopbanhang/\" target=\"_blank\">Kingphone</a>\n"
                + "											</span>\n"
                + "										</b>\n"
                + "									</em>\n"
                + "									\n"
                + "								</span>\n"
                + "							</i>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\">\n"
                + "								<span></span>\n"
                + "					</span>\n"
                + "				</p>\n"
                + "				<p class=\"MsoNormal\" style=\"text-indent:0.25in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<em>\n"
                + "								<b>\n"
                + "									<span style=\"font-family:arial,sans-serif\">Thông tin của bạn&nbsp;&nbsp;</span>\n"
                + "								</b>\n"
                + "							</em>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\">\n"
                + "								<span></span>\n"
                + "					</span>\n"
                + "				</p>\n"
                + "				<p style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<em>\n"
                + "								<span style=\"font-size:9.5pt;font-family:arial,sans-serif;font-style:normal\">-\n"
                + "									<span style=\"font-variant-numeric:normal;font-stretch:normal\"></span>\n"
                + "								</span>\n"
                + "							</em>\n"
                + "					<em>\n"
                + "								<span style=\"font-size:7pt;font-family:arial,sans-serif;font-style:normal\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>\n"
                + "							</em>\n"
                + "					<span>\n"
                + "								<span style=\"font-size:7pt;font-family:arial,sans-serif\">&nbsp;</span>\n"
                + "					</span>\n"
                + "					<em>\n"
                + "								<span style=\"font-family:arial,sans-serif\">Tên tài khoản: " + username + "\n"
                + "									<span style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\"></span>\n"
                + "								</span>\n"
                + "							</em>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\"></span>\n"
                + "					<span></span>\n"
                + "				</p>\n"
                + "				<p style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<em>\n"
                + "								<span style=\"font-size:9.5pt;font-family:arial,sans-serif;font-style:normal\">-\n"
                + "									<span style=\"font-variant-numeric:normal;font-stretch:normal\"></span>\n"
                + "								</span>\n"
                + "							</em>\n"
                + "					<em>\n"
                + "								<span style=\"font-size:7pt;font-family:arial,sans-serif;font-style:normal\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>\n"
                + "							</em>\n"
                + "					<span>\n"
                + "								<span style=\"font-size:7pt;font-family:arial,sans-serif\">&nbsp;</span>\n"
                + "					</span>\n"
                + "					<em>\n"
                + "								<span style=\"font-family:arial,sans-serif\">Tên đầy đủ: " + fullname + "\n"
                + "									<span style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">&nbsp;</span>\n"
                + "								</span>\n"
                + "							</em>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\"></span>\n"
                + "					<span></span>\n"
                + "				</p>\n"
                + "				<p style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<em>\n"
                + "								<span style=\"font-size:9.5pt;font-family:arial,sans-serif;font-style:normal\">-\n"
                + "									<span style=\"font-variant-numeric:normal;font-stretch:normal\"></span>\n"
                + "								</span>\n"
                + "							</em>\n"
                + "					<em>\n"
                + "								<span style=\"font-size:7pt;font-family:arial,sans-serif;font-style:normal\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>\n"
                + "							</em>\n"
                + "					<span>\n"
                + "								<span style=\"font-size:7pt;font-family:arial,sans-serif\">&nbsp;</span>\n"
                + "					</span>\n"
                + "					<em>\n"
                + "								<span style=\"font-family:arial,sans-serif\">Điện thoại:\n"
                + "									<span style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">&nbsp;</span>\n"
                + "									<a href=\"\" target=\"_blank\">\n"
                + "										<span style=\"color:rgb(34,34,34)\">\n"
                + "											<span style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">" + phone + "</span>\n"
                + "										</span>\n"
                + "									</a>\n"
                + "									<span style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">&nbsp;</span>\n"
                + "								</span>\n"
                + "							</em>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\"></span>\n"
                + "					<span></span>\n"
                + "				</p>\n"
                + "				<p style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<em>\n"
                + "								<span style=\"font-size:9.5pt;font-family:arial,sans-serif;font-style:normal\">-\n"
                + "									<span style=\"font-variant-numeric:normal;font-stretch:normal\"></span>\n"
                + "								</span>\n"
                + "							</em>\n"
                + "					<em>\n"
                + "								<span style=\"font-size:7pt;font-family:arial,sans-serif;font-style:normal\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>\n"
                + "							</em>\n"
                + "					<span>\n"
                + "								<span style=\"font-size:7pt;font-family:arial,sans-serif\">&nbsp;</span>\n"
                + "					</span>\n"
                + "					<em>\n"
                + "								<span style=\"font-family:arial,sans-serif\">Email:\n"
                + "									<span style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">&nbsp;</span>\n"
                + "									<a href=\"\" target=\"_blank\">\n"
                + "										<span style=\"color:rgb(34,34,34)\">\n"
                + "											<span style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">" + email + "</span>\n"
                + "										</span>\n"
                + "									</a>\n"
                + "									<span style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\"></span>\n"
                + "								</span>\n"
                + "							</em>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\"></span>\n"
                + "					<span></span>\n"
                + "				</p>\n"
                + "								<p class=\"MsoNormal\" style=\"text-indent:0.25in;background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<em>\n"
                + "								<b>\n"
                + "									<span style=\"font-family:arial,sans-serif\">Thông tin đơn hàng của bạn&nbsp;&nbsp;</span>\n"
                + "								</b>\n"
                + "							</em>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\">\n"
                + "								<span></span>\n"
                + "					</span>\n"
                + "				</p>\n"
                + "				<p style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<em>\n"
                + "								<span style=\"font-size:9.5pt;font-family:arial,sans-serif;font-style:normal\">-\n"
                + "									<span style=\"font-variant-numeric:normal;font-stretch:normal\"></span>\n"
                + "								</span>\n"
                + "							</em>\n"
                + "					<em>\n"
                + "								<span style=\"font-size:7pt;font-family:arial,sans-serif;font-style:normal\">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>\n"
                + "							</em>\n"
                + "					<span>\n"
                + "								<span style=\"font-size:7pt;font-family:arial,sans-serif\">&nbsp;</span>\n"
                + "					</span>\n"
                + "					<em>\n"
                + "								<span style=\"font-family:arial,sans-serif\">Tổng tiền đơn hàng: " + total + " VNĐ\n"
                + "									<span style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\"></span>\n"
                + "								</span>\n"
                + "							</em>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\"></span>\n"
                + "					<span></span>\n"
                + "				</p>\n"
                + "				<p class=\"MsoNormal\" style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<em>\n"
                + "								<span style=\"font-family:arial,sans-serif;color:red;\">" + content + "</span>\n"
                + "							</em>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\">\n"
                + "								<span></span>\n"
                + "					</span>\n"
                + "				</p>\n"
                + "				<p class=\"MsoNormal\" style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<em>\n"
                + "								<span style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "									<span style=\"font-family:arial,sans-serif\">&nbsp;</span>\n"
                + "								</span>\n"
                + "							</em>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\">\n"
                + "								<span></span>\n"
                + "					</span>\n"
                + "				</p>\n"
                + "				<p class=\"MsoNormal\" style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<em>\n"
                + "								<b>\n"
                + "									<span style=\"font-family:arial,sans-serif\">Trân trọng,</span>\n"
                + "								</b>\n"
                + "							</em>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\">\n"
                + "								<span></span>\n"
                + "					</span>\n"
                + "				</p>\n"
                + "				<p class=\"MsoNormal\" style=\"background-image:initial;background-position:initial;background-size:initial;background-repeat:initial;background-origin:initial;background-clip:initial\">\n"
                + "					<em>\n"
                + "								<b>\n"
                + "									<span style=\"font-family:arial,sans-serif\">Trung tâm hỗ trợ,</span>\n"
                + "								</b>\n"
                + "							</em>\n"
                + "					<span style=\"font-size:9.5pt;font-family:arial,sans-serif\">\n"
                + "								<span></span>\n"
                + "					</span>\n"
                + "				</p>\n"
                + "			</div>\n"
                + "		</div>\n"
                + "	</div>\n"
                + "</body>\n"
                + "</html>";

        return MailContent;
    }

}
