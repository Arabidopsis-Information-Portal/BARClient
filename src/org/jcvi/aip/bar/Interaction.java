/**
 * 
 */
package org.jcvi.aip.bar;

/**
 * @author erik
 *
 */
public class Interaction {
	private Protein proteinA;
	private Protein proteinB;
	
	public Interaction(Protein a, Protein b) {
		this.proteinA = a;
		this.proteinB = b;
	}
	
	/**
	 * @return the proteinA
	 */
	public Protein getProteinA() {
		return proteinA;
	}
	/**
	 * @param proteinA the proteinA to set
	 */
	public void setProteinA(Protein proteinA) {
		this.proteinA = proteinA;
	}
	/**
	 * @return the proteinB
	 */
	public Protein getProteinB() {
		return proteinB;
	}
	/**
	 * @param proteinB the proteinB to set
	 */
	public void setProteinB(Protein proteinB) {
		this.proteinB = proteinB;
	}

}
