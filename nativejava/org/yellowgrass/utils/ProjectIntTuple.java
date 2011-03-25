package org.yellowgrass.utils;
import webdsl.generated.domain.Project;


public class ProjectIntTuple {
	public Project p;
	public Integer i;
	public ProjectIntTuple(Project p, Integer i) {
		super();
		this.p = p;
		this.i = i;
	}
	public Project getP() {
		return p;
	}
	public void setP(Project p) {
		this.p = p;
	}
	public Integer getI() {
		return i;
	}
	public void setI(Integer i) {
		this.i = i;
	}
}
