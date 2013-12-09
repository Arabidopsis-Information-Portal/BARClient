/**
 * 
 */
package org.jcvi.aip.factory;

import org.jcvi.aip.spi.BARClientSpi;
import org.jcvi.aip.spi.impl.WebClientSpiImpl;

/**
 * @author erik
 *
 */
public class BARClientFactory {
	
	public static final BARClientSpi getInstance(String initParams) {
		BARClientSpi spi = null;
		if (initParams.compareToIgnoreCase("webclient") == 0) {
			spi = new WebClientSpiImpl();
		} else {
			spi = new WebClientSpiImpl();
		}
		return spi;
	}

}
