/**
 * 
 */
package org.jcvi.aip.bar;

/**
 * @author erik
 *
 */
public class Protein {
	private int id;
	private String name;
	
	public Protein(String name) {
		this.name = name;
	}
	
	public Protein(String name, int id) {
		this.name = name;
		this.id = id;
	}
	
	/**
	 * @return the id
	 */
	public int getId() {
		return id;
	}
	/**
	 * @param id the id to set
	 */
	public void setId(int id) {
		this.id = id;
	}
	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}
	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

}
