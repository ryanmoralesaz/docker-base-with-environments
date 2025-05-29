import http.server
import socketserver
PORT = 8080
Handler = http.server.SimpleHTTPRequestHandler
with socketserver.TCPServer(('0.0.0.0', PORT), Handler) as httpd:
    print(f'Server running on 0.0.0.0:{PORT}')
    httpd.serve_forever()