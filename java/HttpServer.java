import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.HashMap;
import java.util.Map;
import java.net.URI;
import java.net.URISyntaxException;

public class HttpServer {
    public static void main(String[] args) {
        try {
            int cores = Runtime.getRuntime().availableProcessors();
            ExecutorService executor = Executors.newFixedThreadPool(1);

            ServerSocket serverSocket = new ServerSocket(8080);

            while (true) {
                System.out.println("Ожидание входящего соединения...");
                Socket clientSocket = serverSocket.accept();

                executor.execute(() -> {
                    try {
                        BufferedReader reader = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                        String line;
                        String uriPath = "";
                        while ((line = reader.readLine()) != null && !line.isEmpty()) {
                            System.out.println(line);
                            if (line.startsWith("GET")) {
                                uriPath = line.split(" ")[1];
                            }
                        }

                        if (uriPath.contains("/fibonacci")) {
                            System.out.println(uriPath);
                            Map params=parse(uriPath);
                            String value=(String)params.get("value");

                            int fibonacciResult = fibonacci(32);

                            String response = "HTTP/1.1 200 OK\r\n" +
                                    "Content-Type: text/html\r\n\r\n" +
                                    "<html><body>" +
                                    "<p>fibonacciResult 32: " + fibonacciResult + "</p>" +
                                    "</body></html>";

                            OutputStream outputStream = clientSocket.getOutputStream();
                            outputStream.write(response.getBytes("UTF-8"));

                            outputStream.close();
                        } else {
                            String response = "HTTP/1.1 404 Not Found\r\n\r\n";
                            OutputStream outputStream = clientSocket.getOutputStream();
                            outputStream.write(response.getBytes("UTF-8"));
                            outputStream.close();
                        }

                        reader.close();
                        clientSocket.close();
                    } catch (URISyntaxException e) {
                        e.printStackTrace();
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                });
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static HashMap<String, String> parse(String url) throws URISyntaxException {
        HashMap<String, String> params = new HashMap<>();
        URI uri = new URI(url);
        String query = uri.getQuery();
        if (query != null) {
            String[] pairs = query.split("&");
            for (String pair : pairs) {
                int idx = pair.indexOf("=");
                String key = idx > 0 ? pair.substring(0, idx) : pair;
                String value = idx > 0 && pair.length() > idx + 1 ? pair.substring(idx + 1) : null;
                params.put(key, value);
            }
        }
        return params;
    }

    private static int fibonacci(int n) {
        if (n <= 1) {
            return n;
        }
        return fibonacci(n - 1) + fibonacci(n - 2);
    }
}
