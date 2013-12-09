package org.jcvi.aip;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jcvi.aip.bar.Graph;
import org.jcvi.aip.factory.BARClientFactory;
import org.jcvi.aip.spi.BARClientSpi;

/**
 * Servlet implementation class BARClientServlet
 */
@WebServlet("/BARClientServlet")
public class BARClientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BARClientServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			
			String query = request.getParameter("query");
			if (query == null || query.equals("")) {
				query = "AT1G10940";
			}
			
			BARClientSpi client = BARClientFactory.getInstance("webclient");
			Graph graph = client.load(query);
			String json = graph.toJSON();
			
			response.setContentType("application/json");
			PrintWriter pw = response.getWriter();
			pw.print(json);
			pw.flush();
			
			
		} catch (Exception e) {
			throw new ServletException(e.getMessage());
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

}
