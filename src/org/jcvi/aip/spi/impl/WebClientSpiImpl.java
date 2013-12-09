/**
 * 
 */
package org.jcvi.aip.spi.impl;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.ConnectException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.jcvi.aip.bar.Graph;
import org.jcvi.aip.bar.Interaction;
import org.jcvi.aip.bar.Protein;
import org.jcvi.aip.spi.BARClientSpi;

/**
 * @author erik
 *
 */
public class WebClientSpiImpl extends BARClientSpi {

	/* (non-Javadoc)
	 * @see org.jcvi.aip.spi.BARClientSpi#load(java.lang.String)
	 */
	@Override
	public Graph load(String query) throws Exception {
		HttpURLConnection conn = null;
		try {
			URL url = new URL("http://bar.utoronto.ca:9090/psicquic/webservices/current/search/query" + "/" + query);
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
		
			if (conn.getResponseCode() != 200) {
				throw new ConnectException("Failed: HTTP error code: " + conn.getResponseCode());
			}
		
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String output;
			Graph g = new Graph(query);
			while ((output = br.readLine()) != null) {
				String[] fields = output.trim().split("\t");
				Protein a = new Protein(fields[0].toUpperCase().replace("TAIR:", ""));
				g.addProtein(a);
				Protein b = new Protein(fields[1].toUpperCase().replace("TAIR:", ""));
				g.addProtein(b);
				Interaction i = new Interaction(a, b);
				g.addInteraction(i);
			}
			return g;
		} catch (MalformedURLException e) {
			throw new Exception(e.getMessage());
		} catch (IOException e) {
			throw new Exception(e.getMessage());
		} finally {
			if (conn != null) {
				conn.disconnect();
			}
		}
	}

}
