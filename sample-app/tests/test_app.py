import unittest
from app import app

class TestSampleApp(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()

    def test_hello_endpoint(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data, b'Hello, World!')
        
    def test_metrics_endpoint(self):
        response = self.app.get('/metrics')
        self.assertEqual(response.status_code, 200)
        self.assertIn('http_requests_total', response.data.decode())

if __name__ == '__main__':
    unittest.main()
        
