/**
 * 
 */
package org.jcvi.aip.bar;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;;

/**
 * @author erik
 *
 */
public class Graph {
	
	private String name;
	private Set<Protein> proteins;
	private List<Interaction> interactions;
	
	public Graph(String name) {
		this.name = name;
		proteins = new HashSet<Protein>();
		interactions = new ArrayList<Interaction>();
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
	/**
	 * @return the proteins
	 */
	public Set getProteins() {
		return proteins;
	}
	/**
	 * @param proteins the proteins to set
	 */
	public void setProteins(Set proteins) {
		this.proteins = proteins;
	}
	/**
	 * @return the interaction
	 */
	public List getInteractions() {
		return interactions;
	}
	/**
	 * @param interaction the interaction to set
	 */
	public void setInteractions(List interactions) {
		this.interactions = interactions;
	}
	
	public void addProtein(Protein protein) {
		if (!proteins.contains(protein)) {
			proteins.add(protein);
		}
	}
	
	public void addInteraction(Interaction interaction) {
		interactions.add(interaction);
	}
	
	public String toJSON() {
		StringBuffer buf = new StringBuffer();
		buf.append("{ \"nodes\": [");
		boolean first = true;
		for (Protein p : proteins) {
			if (!first) {
				buf.append(",");
			}
			buf.append(" { \"data\": { \"id\": \"" + p.getName() + "\", \"name\": \"" + p.getName() + "\" } }");
			first = false;
		}
		buf.append(" ], \"edges\": [");
		first = true;
		for (Interaction i : interactions) {
			if (!first) {
				buf.append(",");
			}
			buf.append(" { \"data\": { \"source\": \"" + i.getProteinA().getName() + "\", \"target\": \"" + i.getProteinB().getName() + "\" } }");
			first = false;
		}
		buf.append(" ] }");
		return buf.toString();
	}

}
