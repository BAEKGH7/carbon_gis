package servlet.VO;

import org.apache.ibatis.type.Alias;

@Alias("ServletVO")
public class ServletVO {
	private String geom, bjd_cd, bjd_nm, sgg_cd, sgg_nm, sd_cd, sd_nm;
	

	public String getGeom() {
		return geom;
	}

	public void setGeom(String geom) {
		this.geom = geom;
	}

	public String getBjd_cd() {
		return bjd_cd;
	}

	public void setBjd_cd(String bjd_cd) {
		this.bjd_cd = bjd_cd;
	}

	public String getBjd_nm() {
		return bjd_nm;
	}

	public void setBjd_nm(String bjd_nm) {
		this.bjd_nm = bjd_nm;
	}

	public String getSgg_cd() {
		return sgg_cd;
	}

	public void setSgg_cd(String sgg_cd) {
		this.sgg_cd = sgg_cd;
	}

	public String getSgg_nm() {
		return sgg_nm;
	}

	public void setSgg_nm(String sgg_nm) {
		this.sgg_nm = sgg_nm;
	}

	public String getSd_cd() {
		return sd_cd;
	}

	public void setSd_cd(String sd_cd) {
		this.sd_cd = sd_cd;
	}

	public String getSd_nm() {
		return sd_nm;
	}

	public void setSd_nm(String sd_nm) {
		this.sd_nm = sd_nm;
	}




	
}
