#!/usr/bin/env python3
import requests
import json

class CaronteAPI:
    def __init__(self, base_url="http://localhost:3752"):
        self.base_url = base_url
        
    def get_connections(self, filters=None):
        """Get captured connections"""
        url = f"{self.base_url}/api/connections"
        if filters:
            url += "?" + "&".join(f"{k}={v}" for k,v in filters.items())
        return requests.get(url).json()
    
    def get_extracted_data(self, connection_id):
        """Get extracted data from a connection"""
        url = f"{self.base_url}/api/connections/{connection_id}/extracted"
        return requests.get(url).json()
    
    def get_statistics(self):
        """Get capture statistics"""
        url = f"{self.base_url}/api/statistics"
        return requests.get(url).json()

def main():
    api = CaronteAPI()
    
    # Get recent connections
    connections = api.get_connections({
        "limit": 10,
        "sort": "timestamp",
        "order": "desc"
    })
    
    print("\nRecent Connections:")
    for conn in connections:
        print(f"ID: {conn['id']}")
        print(f"Source: {conn['src_ip']}:{conn['src_port']}")
        print(f"Dest: {conn['dst_ip']}:{conn['dst_port']}")
        print(f"Service: {conn.get('service_name', 'unknown')}")
        print("---")
        
        # Get extracted data
        data = api.get_extracted_data(conn['id'])
        if data:
            print("Extracted Data:")
            print(json.dumps(data, indent=2))
            print("---")

if __name__ == "__main__":
    main() 