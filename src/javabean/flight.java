package javabean;
/********************
*@author created by xiaohutuxian
*@date  2019��6��15��---����8:37:42
*@IDE	eclipse
*@jdk	1.8.0_161
*********************/
public class flight {
	private String f_n=null;//�����
	private String f_s_a=null;//��ɻ���
	private String f_a_a=null;//�������
	private String f_d_t=null;//���ʱ��
	private String f_a_t=null;//����ʱ��
	private String f_f_c_p=null;//ͷ�Ȳռ۸�
	private String f_s_c_p=null;//����ռ۸�
	private String f_t_c_p=null;//���òռ۸�
	private String fir_cnt = null;
	private String bus_cnt = null;
	private String eoc_cnt = null;
	private String depart_date = null;
	private String company = null;
	private  String flytime = null;

	public String getFlytime() {
		return flytime;
	}

	public void setFlytime(String flytime) {
		this.flytime = flytime;
	}

	public String getF_n() {
		return f_n;
	}
	public void setF_n(String f_n) {
		this.f_n = f_n;
	}
	public String getF_s_a() {
		return f_s_a;
	}
	public void setF_s_a(String f_s_a) {
		this.f_s_a = f_s_a;
	}
	public String getF_a_a() {
		return f_a_a;
	}
	public void setF_a_a(String f_a_a) {
		this.f_a_a = f_a_a;
	}
	public String getF_d_t() {
		return f_d_t;
	}
	public void setF_d_t(String f_d_t) {
		this.f_d_t = f_d_t;
	}
	public String getF_a_t() {
		return f_a_t;
	}
	public void setF_a_t(String f_a_t) {
		this.f_a_t = f_a_t;
	}
	public String getF_f_c_p() {
		return f_f_c_p;
	}
	public void setF_f_c_p(String f_f_c_p) {
		this.f_f_c_p = f_f_c_p;
	}
	public String getF_s_c_p() {
		return f_s_c_p;
	}
	public void setF_s_c_p(String f_s_c_p) {
		this.f_s_c_p = f_s_c_p;
	}
	public String getF_t_c_p() {
		return f_t_c_p;
	}
	public void setF_t_c_p(String f_t_c_p) {
		this.f_t_c_p = f_t_c_p;
	}
	public String getEoc_cnt() {
		return eoc_cnt;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public void setEoc_cnt(String eoc_cnt) {
		this.eoc_cnt = eoc_cnt;
	}
	public String getBus_cnt() {
		return bus_cnt;
	}
	public void setBus_cnt(String bus_cnt) {
		this.bus_cnt = bus_cnt;
	}
	public String getFir_cnt() {
		return fir_cnt;
	}
	public void setFir_cnt(String fir_cnt) {
		this.fir_cnt = fir_cnt;
	}
	public String getDepart_date() {
		return depart_date;
	}
	public void setDepart_date(String depart_date) {
		this.depart_date = depart_date;
	}
}
