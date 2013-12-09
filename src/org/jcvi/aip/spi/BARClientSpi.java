/**
 * 
 */
package org.jcvi.aip.spi;

import org.jcvi.aip.bar.Graph;

/**
 * @author erik
 *
 */
public abstract class BARClientSpi {
	
	public abstract Graph load(String query) throws Exception;

}
