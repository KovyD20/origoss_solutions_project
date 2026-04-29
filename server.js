import { createServer } from 'http';

const PORT = process.env.PORT || 30000;

const server = createServer((req, res) => {
  if (req.url === '/' && req.method === 'GET') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello, World!');
  } else {
    res.writeHead(404);
    res.end();
  }
});

server.listen(PORT, () => console.log(`Server running on port ${PORT} 
    - http://localhost:${PORT}`));
