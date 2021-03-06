package com.examstack.common.domain.user;

public class Department {

	private int depId;
	private String depName;
	private String memo;
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public int getDepId() {
		return depId;
	}
	public void setDepId(int depId) {
		this.depId = depId;
	}
	public String getDepName() {
		return depName;
	}
	public void setDepName(String depName) {
		this.depName = depName;
	}

	//增加树结构
	private int depParentId;
	private String depTreePath;

	public int getDepParentId() {
		return depParentId;
	}

	public void setDepParentId(int depParentId) {
		this.depParentId = depParentId;
	}

	public String getDepTreePath() {
		return depTreePath;
	}

	public void setDepTreePath(String depTreePath) {
		this.depTreePath = depTreePath;
	}
}
